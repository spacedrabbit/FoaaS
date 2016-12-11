//
//  FoaasPrevewViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 12/9/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasPrevewViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var previewLabel: UILabel!
  @IBOutlet weak var previewTextView: UITextView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var bottomTextFieldConstraint: NSLayoutConstraint!
  @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var previewTextViewHeightConstraint: NSLayoutConstraint!
  
  internal private(set) var operation: FoaasOperation?
  private var pathBuilder: FoaasPathBuilder?
  
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHeirarchy()
    self.configureConstraints()
    
    self.registerForNotifications()
  }
  
  
  // MARK: - View Setup
  internal func setupViewHeirarchy() {
    self.previewLabel.text = "Preview"
    self.scrollView.alwaysBounceVertical = true
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
    self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
    self.fromLabel.translatesAutoresizingMaskIntoConstraints = false
    self.fromTextField.translatesAutoresizingMaskIntoConstraints = false
    self.wildCardLabel.translatesAutoresizingMaskIntoConstraints = false
    self.wildCardTextField.translatesAutoresizingMaskIntoConstraints = false
    
    self.nameTextField.delegate = self
    self.fromTextField.delegate = self
    self.wildCardTextField.delegate = self
    
    self.scrollView.addSubview(nameLabel)
    self.scrollView.addSubview(nameTextField)
    self.scrollView.addSubview(fromLabel)
    self.scrollView.addSubview(fromTextField)
    self.scrollView.addSubview(wildCardLabel)
    self.scrollView.addSubview(wildCardTextField)
  }
  
  internal func configureConstraints() {
    nameLabel.topAnchor.constraint(equalTo: previewTextView.bottomAnchor, constant: 8.0).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: previewTextView.leadingAnchor).isActive = true
    
    nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0).isActive = true
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    
    fromLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8.0).isActive = true
    fromLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
    
    fromTextField.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8.0).isActive = true
    fromTextField.leadingAnchor.constraint(equalTo: fromLabel.leadingAnchor).isActive = true
    
    wildCardLabel.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 8.0).isActive = true
    wildCardLabel.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor).isActive = true
    
    wildCardTextField.topAnchor.constraint(equalTo: wildCardLabel.bottomAnchor, constant: 8.0).isActive = true
    wildCardTextField.leadingAnchor.constraint(equalTo: wildCardLabel.leadingAnchor).isActive = true
    
    wildCardTextField.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: 0.0).isActive = true
  }
  
  
  // MARK: - Keyboard Notification
  private func registerForNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  internal func keyboardDidAppear(notification: Notification) {
    self.shouldShowKeyboard(show: true, notification: notification, completion: nil)
  }
  
  internal func keyboardWillDisappear(notification: Notification) {
    self.shouldShowKeyboard(show: false, notification: notification, completion: nil)
  }
  
  private func shouldShowKeyboard(show: Bool, notification: Notification, completion: ((Bool) -> Void)? ) {
    if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
      let animationNumber = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber,
      let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
      let animationOption = UIViewAnimationOptions(rawValue: animationNumber.uintValue)
      
      scrollViewBottomConstraint.constant = keyboardFrame.size.height * (show ? 1 : -1)
      UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationOption, animations: {
        self.view.layoutIfNeeded()
      }, completion: completion)
      
    }
  }
  
  private func updateTextFieldHeight(animated: Bool) {
    let textContainterInsets = self.previewTextView.textContainerInset
    let usedRect = self.previewTextView.layoutManager.usedRect(for: self.previewTextView.textContainer)
    
    self.previewTextViewHeightConstraint.constant = usedRect.size.height + textContainterInsets.top + textContainterInsets.bottom
    // TODO: ensure that after typing, if additional lines are added that the textfield expands to accomodate this as well
//    self.previewTextView.textContainer.heightTracksTextView = true

    if !animated { return }
    UIView.animate(withDuration: 0.2, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  
  // MARK: - Actions
  @IBAction func didPressDone(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  // MARK: - Other
  internal func set(operation: FoaasOperation?) {
    guard let validOp = operation else { return }
    
    self.operation = validOp
    self.pathBuilder = FoaasPathBuilder(operation: validOp)
    
    self.request(operation: validOp)
  }
  
  internal func request(operation: FoaasOperation) {
    guard
      let validPathBulder = self.pathBuilder,
      let url = URL(string: validPathBulder.build())
    else {
      return
    }
    
    FoaasAPIManager.getFoaas(url: url, completion: { (foaas: Foaas?) in
      guard let validFoaas = foaas else {
        return
      }
      
      DispatchQueue.main.async {
        self.previewTextView.text = validFoaas.message + "\n" + validFoaas.subtitle
        self.updateTextFieldHeight(animated: true)
      }
    })
  }
  
  // MARK: - UITextField Delegate
  func textFieldDidEndEditing(_ textField: UITextField) {
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return true
  }
  
  // MARK: - Lazy Loaders
  internal lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Name"
    label.font = UIFont.systemFont(ofSize: 18.0)
    return label
  }()
  
  internal lazy var nameTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "name"
    textField.borderStyle = .bezel
    return textField
  }()
  
  internal lazy var fromLabel: UILabel = {
    let label = UILabel()
    label.text = "Frome"
    label.font = UIFont.systemFont(ofSize: 18.0)
    return label
  }()
  
  internal lazy var fromTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "from"
    textField.borderStyle = .bezel
    return textField
  }()
  
  internal lazy var wildCardLabel: UILabel = {
    let label = UILabel()
    label.text = "Reference"
    label.font = UIFont.systemFont(ofSize: 18.0)
    return label
  }()
  
  internal lazy var wildCardTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "reference"
    textField.borderStyle = .bezel
    return textField
  }()
}
