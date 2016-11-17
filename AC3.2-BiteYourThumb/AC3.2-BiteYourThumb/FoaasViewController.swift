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
        
        print("about to animate")
        UIView.animate(withDuration: 0.2, animations: { 
          self.foaasLabel.alpha = 0.0
          print("in animation block")
        }, completion: { (complete: Bool) in
          if complete {
              print("Completed")
//            DispatchQueue.main.async {
              self.foaasLabel.text = foaas!.description.lowercased()
//            }
            
            UIView.animate(withDuration: 0.15, animations: { 
              self.foaasLabel.alpha = 1.0
            }, completion: nil)
          }
        })
        
      }
    }
  }
  
}

