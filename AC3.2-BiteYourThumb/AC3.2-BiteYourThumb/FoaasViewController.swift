//
//  ViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasView: UIView {
  
  // MARK: - Setup
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(resizingView)
    self.addSubview(addButton)
    self.resizingView.addSubview(textField)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.resizingView.translatesAutoresizingMaskIntoConstraints = false
    self.textField.translatesAutoresizingMaskIntoConstraints = false
    self.addButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.backgroundColor = .yellow
  }
  
  internal func configureConstraints() {
    let resizingViewConstraints = [
      resizingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      resizingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      resizingView.topAnchor.constraint(equalTo: self.topAnchor),
      resizingView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -48.0)
    ]
    
    let fieldConstraints = [
      textField.leadingAnchor.constraint(equalTo: resizingView.leadingAnchor),
      textField.topAnchor.constraint(equalTo: resizingView.topAnchor),
      textField.trailingAnchor.constraint(equalTo: resizingView.trailingAnchor),
      textField.widthAnchor.constraint(equalToConstant: 375.0),
      textField.bottomAnchor.constraint(equalTo: resizingView.bottomAnchor),
      textField.heightAnchor.constraint(equalTo: resizingView.heightAnchor),
    ]
    
    let buttonConstraints = [
      addButton.widthAnchor.constraint(equalToConstant: 54.0),
      addButton.heightAnchor.constraint(equalToConstant: 54.0),
      addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -48.0),
      addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -48.0)
    ]

    let _ = [resizingViewConstraints, fieldConstraints, buttonConstraints].map{ $0.map{ $0.isActive = true } }
  }
  
  override func layoutSubviews() {
    // TOOD: adjust sizing
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  // MARK: - Lazy Inits
  internal lazy var resizingView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  // TODO: fix this stupid ass textfield
  internal lazy var textField: UITextField = {
    let textField = UITextField(frame: CGRect.zero)
    textField.font = UIFont.systemFont(ofSize: 64.0)
    textField.textColor = .black
    textField.textAlignment = .left
    textField.isUserInteractionEnabled = false
    textField.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    return textField
  }()
  
  internal lazy var addButton: UIButton = {
    let button: UIButton = UIButton(type: .custom)
    button.setBackgroundImage(UIImage(named: "add_button")!, for: .normal)
    return button
  }()
}

class FoaasViewController: UIViewController {
  
//  @IBOutlet weak var foaasLabel: UILabel!
//  @IBOutlet weak var foaasMessageScrollView: UIScrollView!
  
  // TODO: replace IB w/ programmatic
  let foaasView: FoaasView = FoaasView(frame: CGRect.zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(foaasView)
    let _ = [
      foaasView.topAnchor.constraint(equalTo: self.view.topAnchor),
      foaasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      foaasView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      foaasView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
      ].map{ $0.isActive = true }
    
    // TODO: re-add tap gesture
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(createScreenShot))
//    self.view.addGestureRecognizer(tapGesture)
    
    self.makeRequest()
  }
  
  override func viewDidLayoutSubviews() {
    
  }
  
  internal func createScreenShot() {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
    self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    UIImageWriteToSavedPhotosAlbum(image!, self, #selector(createScreenShotCompletion(image:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @IBAction func didTapOctoButton(_ sender: UIButton) {
    let newTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    let originalTransform = sender.imageView!.transform
    
    UIView.animate(withDuration: 0.1, animations: {
      sender.layer.transform = CATransform3DMakeAffineTransform(newTransform)
    }, completion: { (complete) in
      sender.layer.transform = CATransform3DMakeAffineTransform(originalTransform)
    })
  }
  
  internal func createScreenShotCompletion(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: UnsafeMutableRawPointer?) {
    if didFinishSavingWithError != nil {
      print("Error encountered with saving image: \(didFinishSavingWithError!)")
      
      let failAlert = UIAlertController(title: "Image Not Saved", message: didFinishSavingWithError!.description, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      failAlert.addAction(okAction)
      
      self.present(failAlert, animated: true, completion: nil)
    }
    else {
      let successAlert = UIAlertController(title: "Image Saved", message: nil, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      successAlert.addAction(okAction)
      
      self.present(successAlert, animated: true, completion: nil)
    }
    
  }
  
  internal func registerForNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(updateFoaas(sender:)), name: Notification.Name(rawValue: "FoaasObjectDidUpdate"), object: nil)
  }
  
  internal func updateFoaas(sender: Any) {
    // TODO
  }
  
  internal func makeRequest() {
    FoaasAPIManager.getFoaas { (foaas: Foaas?) in
      
      if foaas != nil {
//        self.foaasLabel.alpha = 0.0
        
        DispatchQueue.main.async {
          self.foaasView.textField.text = foaas!.description.lowercased()
          
          UIView.animate(withDuration: 0.25, animations: {
//            self.foaasLabel.alpha = 1.0
          })
        }
      }
    }
  }
  
}

