//
//  FoaasNavigationController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

enum FoaasNavItem {
  case done, cancel
}

class FoaasNavigationController: UINavigationController {
  
  private var rightBarItem: UIBarButtonItem?
  private var leftBarItem: UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func adjustRightBar(to item: FoaasNavItem) {
    switch item {
    case .done, .cancel:
      if let topVC = self.topViewController {
        topVC.navigationItem.setRightBarButton(self.dismissButton(with: "Done"), animated: true)
      }
    }
    
  }
  
  internal func dismissButton(with text: String) -> UIBarButtonItem {
    return UIBarButtonItem(title: text, style: .done, target: self, action: #selector(dismissFoaas))
  }
  
  internal func dismissFoaas() {
    self.dismiss(animated: true, completion: nil)
  }
}
