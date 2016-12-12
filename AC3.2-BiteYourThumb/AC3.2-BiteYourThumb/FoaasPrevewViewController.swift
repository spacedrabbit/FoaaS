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
  internal private(set) var slidingTextFields: [SlidingTextField] = []
  
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
    
    for key in self.pathBuilder!.allKeys() {
      let newSlidingTextField = SlidingTextField(placeHolderText: key)
      slidingTextFields.append(newSlidingTextField)
      self.scrollView.addSubview(newSlidingTextField)
    }
  }
  
  internal func configureConstraints() {

    var priorTextField: SlidingTextField?
    for (idx, textField) in slidingTextFields.enumerated() {
      
      switch idx {
      // first view needs to be pinned to preview view
      case 0:
        textField.topAnchor.constraint(equalTo: previewTextView.bottomAnchor, constant: 8.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: previewTextView.leadingAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: previewTextView.widthAnchor).isActive = true
        
      // last view needs to be pinned to the bottom, in addition to all of the other constraints
      case slidingTextFields.count - 1:
        textField.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: 0.0).isActive = true
        fallthrough
        
      // middle views need to be pinned to prior view
      default:
        textField.topAnchor.constraint(equalTo: priorTextField!.bottomAnchor, constant: 8.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: priorTextField!.leadingAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: priorTextField!.widthAnchor).isActive = true

      }
      priorTextField = textField
    }
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
}
