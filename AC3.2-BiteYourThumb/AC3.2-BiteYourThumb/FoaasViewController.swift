//
//  ViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasViewController: UIViewController {

  @IBOutlet weak var foaasLabel: UILabel!
  @IBOutlet weak var foaasMessageScrollView: UIScrollView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(createScreenShot))
    self.view.addGestureRecognizer(tapGesture)
    
    self.makeRequest()
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let newButton = RotatingMenuButton(frame: CGRect.init(origin: self.view.center, size: CGSize.zero))
    self.view.addSubview(newButton)
    
    let centerConstraintsX = NSLayoutConstraint(item: newButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    let centerConstraintsY = NSLayoutConstraint(item: newButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
    
    self.view.addConstraints([centerConstraintsX, centerConstraintsY])
  }
  
  internal func registerForNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(updateFoaas(sender:)), name: Notification.Name(rawValue: "FoaasObjectDidUpdate"), object: nil)
  }
  
  internal func updateFoaas(sender: Any) {
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
//    self.checkBoundingRect()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // TODO: this isn't functioning as I want. Will need re-visiting in a later sprint.
  internal func checkBoundingRect() {
    let screenBounds = UIScreen.main.bounds
    self.foaasLabel.sizeToFit()

    let labelLayerBounds = self.foaasLabel.layer.bounds
    
    let rect = self.foaasLabel.attributedText?.boundingRect(with: CGSize(width: screenBounds.width - 32, height: screenBounds.height), options: .usesLineFragmentOrigin, context: nil)
    
    if Float(labelLayerBounds.size.height) > roundf(Float(rect!.size.height)){
      let fontSize = self.foaasLabel.font.pointSize
      let lineSize = self.foaasLabel.font.lineHeight
      let fontScaleDiff = (lineSize - fontSize) / fontSize
      let sizeScaleDiff = screenBounds.size.height / labelLayerBounds.size.height
      
      
      self.foaasLabel.font = self.foaasLabel.font.withSize((fontSize * (1 - CGFloat(fontScaleDiff))) * (1 - sizeScaleDiff))
    }
    
    self.foaasLabel.frame.size = rect!.size
  }

  internal func makeRequest() {
    FoaasAPIManager.getFoaas { (foaas: Foaas?) in
      
      if foaas != nil {
        self.foaasLabel.alpha = 0.0
        
        DispatchQueue.main.async {
          self.foaasLabel.text = foaas!.description.lowercased()
          UIView.animate(withDuration: 0.25, animations: {
              self.foaasLabel.alpha = 1.0
          })
        }
      }
    }
  }
  
}

