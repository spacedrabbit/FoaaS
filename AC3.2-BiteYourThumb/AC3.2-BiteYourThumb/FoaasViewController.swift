//
//  ViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

// TODO: Build out setting view
class FoaasSettingsView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  internal func setupViewHierarchy() {
    self.backgroundColor = .white
    
    self.addSubview(colorPaletteLabel)
    self.addSubview(profinityFilterLabel)
    
    self.addSubview(profanitySwitch)
    self.addSubview(onLabel)
    self.addSubview(offLabel)
    
    self.addSubview(authorInfoLabel)
    self.addSubview(versionNumberLabel)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    colorPaletteLabel.translatesAutoresizingMaskIntoConstraints = false
    profinityFilterLabel.translatesAutoresizingMaskIntoConstraints = false
    profanitySwitch.translatesAutoresizingMaskIntoConstraints = false
    onLabel.translatesAutoresizingMaskIntoConstraints = false
    offLabel.translatesAutoresizingMaskIntoConstraints = false
    authorInfoLabel.translatesAutoresizingMaskIntoConstraints = false
    versionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  internal func configureConstraints() {
    
    let colorPaletteLabelConstraints = [
      colorPaletteLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
      colorPaletteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
      ]
    
    let profanityLabelConstraints = [
      profinityFilterLabel.topAnchor.constraint(equalTo: colorPaletteLabel.bottomAnchor, constant: 8.0),
      profinityFilterLabel.leadingAnchor.constraint(equalTo: colorPaletteLabel.leadingAnchor)
    ]
    
    let authorLabelConstraints = [
      authorInfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
      authorInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ]
    
    let versionInfoConstraints = [
      versionNumberLabel.bottomAnchor.constraint(equalTo: authorInfoLabel.topAnchor, constant: -8.0),
      versionNumberLabel.centerXAnchor.constraint(equalTo: authorInfoLabel.centerXAnchor),
      
      // TODO: remove this spacing constraint
      versionNumberLabel.topAnchor.constraint(equalTo: profinityFilterLabel.bottomAnchor, constant: 64.0),
      ]
    
    let _ = [colorPaletteLabelConstraints,
             profanityLabelConstraints,
             authorLabelConstraints,
             versionInfoConstraints].map{ $0.map{ $0.isActive = true } }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal lazy var colorPaletteLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "COLOR PALETTE"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var profinityFilterLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "PROFANITY"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var onLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "ON"
    label.textAlignment = .left
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var offLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "OFF"
    label.textAlignment = .left
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var profanitySwitch: UISwitch = {
    let profanitySwitch: UISwitch = UISwitch()
    // TODO: make tint color based on color manager settings
    // TODO: set isON based on settings manager
    return profanitySwitch
  }()
  
  internal lazy var versionNumberLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "V 0.1.0"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    label.textColor = .gray
    return label
  }()
  
  internal lazy var authorInfoLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "MADE WITH ❤️ LOUIS.TUR@GMAIL.COM"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    label.textColor = .gray
    return label
  }()
}

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
  
  // TODO: replace IB w/ programmatic
  let foaasView: FoaasView = FoaasView(frame: CGRect.zero)
  let foaasSettingsView: FoaasSettingsView = FoaasSettingsView(frame: CGRect.zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    // TODO: move to proper function
    self.view.addSubview(foaasSettingsView)
    self.view.addSubview(foaasView)
    let _ = [
      foaasView.topAnchor.constraint(equalTo: self.view.topAnchor),
      foaasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      foaasView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      foaasView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
      ].map{ $0.isActive = true }
    
    let _ = [
      foaasSettingsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      foaasSettingsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      foaasSettingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      ].map{ $0.isActive = true }
    
    self.foaasView.addButton.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchDown)
    
    let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(toggleMenu(sender:)))
    swipeUpGesture.direction = .up
    foaasView.addGestureRecognizer(swipeUpGesture)
    
    let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(toggleMenu(sender:)))
    swipeDownGesture.direction = .down
    foaasView.addGestureRecognizer(swipeDownGesture)
    
    // TODO: re-add tap gesture
    //    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(createScreenShot))
    //    self.view.addGestureRecognizer(tapGesture)
    
    self.makeRequest()
  }
  
  internal func toggleMenu(sender: UISwipeGestureRecognizer) {
    print("Toggle")
    
    switch sender.direction {
    case UISwipeGestureRecognizerDirection.up:
      showMenu()
    case UISwipeGestureRecognizerDirection.down: print("DOWN")
      hideMenu()
    default:
      print("Not interested")
    }
    
  }
  
  internal func showMenu() {
    let originalFrame = self.foaasView.frame
    let newFrame = originalFrame.offsetBy(dx: 0.0, dy: -self.foaasSettingsView.frame.size.height)
    
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: [], animations: {
      self.foaasView.frame = newFrame
    }, completion: nil)
  }
  
  internal func hideMenu() {
    let originalFrame = self.foaasView.frame
    let newFrame = originalFrame.offsetBy(dx: 0.0, dy: self.foaasSettingsView.frame.size.height)
    
    UIView.animate(withDuration: 0.1) {
      self.foaasView.frame = newFrame
    }
  }
  
  internal func createScreenShot() {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
    self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    UIImageWriteToSavedPhotosAlbum(image!, self, #selector(createScreenShotCompletion(image:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @IBAction func didTapAddButton(_ sender: UIButton) {
    let newTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
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

