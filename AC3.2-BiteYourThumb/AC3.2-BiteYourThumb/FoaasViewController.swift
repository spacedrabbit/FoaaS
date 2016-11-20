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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeRequest))
    self.view.addGestureRecognizer(tapGesture)
    
    self.makeRequest()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.checkBoundingRect()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
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

