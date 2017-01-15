//
//  ViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasViewController: UIViewController, FoaasViewDelegate {
  
  let foaasView: FoaasView = FoaasView(frame: CGRect.zero)
  let foaasSettingsView: FoaasSettingsView = FoaasSettingsView(frame: CGRect.zero)
  
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.foaasView.delegate = self
    
    setupViewHierarchy()
    configureConstraints()
    addGesturesAndActions()
    registerForNotifications()

    makeRequest()
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
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
  }
  
  private func setupViewHierarchy() {
    self.view.backgroundColor = .white
    
    self.view.addSubview(foaasSettingsView)
    self.view.addSubview(foaasView)
  }
  
  private func addGesturesAndActions() {
    let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(toggleMenu(sender:)))
    swipeUpGesture.direction = .up
    foaasView.addGestureRecognizer(swipeUpGesture)
    
    let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(toggleMenu(sender:)))
    swipeDownGesture.direction = .down
    foaasView.addGestureRecognizer(swipeDownGesture)
  }
  
  private func registerForNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(updateFoaas(sender:)), name: Notification.Name(rawValue: "FoaasObjectDidUpdate"), object: nil)
  }
  
  
  // MARK: - Animating Menu
  internal func toggleMenu(sender: UISwipeGestureRecognizer) {
    switch sender.direction {
    case UISwipeGestureRecognizerDirection.up:
      animateMenu(show: true, duration: 0.35, dampening: 0.7, springVelocity: 0.6)
      
    case UISwipeGestureRecognizerDirection.down:
      animateMenu(show: false, duration: 0.1)
      
    default: print("Not interested")
    }
  }
  
  private func animateMenu(show: Bool, duration: TimeInterval, dampening: CGFloat = 0.005, springVelocity: CGFloat = 0.005) {
    // ignore toggle request if already in proper position
    switch show {
    case true:
      if self.foaasView.frame.origin.y != 0 { return }
    case false:
      if self.foaasView.frame.origin.y == 0 { return }
    }
    
    let multiplier: CGFloat = show ? -1 : 1
    let originalFrame = self.foaasView.frame
    let newFrame = originalFrame.offsetBy(dx: 0.0, dy: self.foaasSettingsView.frame.size.height * multiplier)
    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: dampening, initialSpringVelocity: springVelocity, options: [], animations: {
      self.foaasView.frame = newFrame
    }, completion: nil)
  }
  
  
  // MARK: - View Delegate 
  func didTapActionButton() {
    guard let navVC = self.navigationController else { return }
    
    let dtvc = FoaasOperationsTableViewController()
    navVC.pushViewController(dtvc, animated: true)
  }
  
  
  // TODO: move screenshot code out
  internal func createScreenShot() {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
    self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    UIImageWriteToSavedPhotosAlbum(image!, self, #selector(createScreenShotCompletion(image:didFinishSavingWithError:contextInfo:)), nil)
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

