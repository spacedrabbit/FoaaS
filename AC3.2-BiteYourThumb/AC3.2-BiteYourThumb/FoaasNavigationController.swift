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

enum FlatNavAction {
  case add, done, back, close
}

enum FlatNavPosition {
  case left, right
}

class FoaasNavigationController: UINavigationController {
  
  private var rightBarItem: UIBarButtonItem?
  private var leftBarItem: UIBarButtonItem?
  
  internal private(set) var leftNavButton: UIButton?
  internal private(set) var rightNavButton: UIButton?
  
  private static let addIcon: UIImage = UIImage(named: "add_button")!
  private static let doneIcon: UIImage = UIImage(named: "done_button")!
  private static let closeIcon: UIImage = UIImage(named: "close_button")!
  private static let backIcon: UIImage = UIImage(named: "back_button")!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNavigationBarHidden(true, animated: false)
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
  
  internal func flatNavigationButton(_ action: FlatNavAction, position: FlatNavPosition) -> UIButton {
    // TODO: change this to use button tint, update tint to use color manager's
    
    let button = UIButton(type: .custom)
    switch action {
    case .add:
      button.setBackgroundImage(FoaasNavigationController.addIcon, for: .normal)
    case .back:
      button.setBackgroundImage(FoaasNavigationController.backIcon, for: .normal)
    case .close:
      button.setBackgroundImage(FoaasNavigationController.closeIcon, for: .normal)
      button.addTarget(self, action: #selector(dismissFoaas), for: .touchUpInside)
    case .done:
      button.setBackgroundImage(FoaasNavigationController.doneIcon, for: .normal)
    }
    
    switch position {
    case .left:
      self.leftNavButton = button
    case .right:
      self.rightNavButton = button
    }
    
    return button
  }
  
}
