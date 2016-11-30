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
    
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeRequest))
//    self.view.addGestureRecognizer(tapGesture)
    
    self.makeRequest()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let newButton = RotatingMenuButton(frame: CGRect.init(origin: self.view.center, size: CGSize.zero))
    self.view.addSubview(newButton)
    
    let centerConstraintsX = NSLayoutConstraint(item: newButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    let centerConstraintsY = NSLayoutConstraint(item: newButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
    
    self.view.addConstraints([centerConstraintsX, centerConstraintsY])
    
//    self.view.layoutIfNeeded()
    newButton.animateIn()
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

