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

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  internal func makeRequest() {
    FoaasManager.getFoaas { (foaas: Foaas?) in
      
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

