//
//  RotatingMenuButton.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MenuView: UIView {
  var widthConstraint: NSLayoutConstraint!
  var heightConstraint: NSLayoutConstraint!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class RotatingMenuButton: UIView {
  private let rotationDuration: TimeInterval = 0.75
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    let tapGes = UITapGestureRecognizer(target: self, action: #selector(rotateOpen))
    self.addGestureRecognizer(tapGes)
    
    self.setupStackSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal func rotateOpen() {
    
    var rotateAffine: CGAffineTransform
    if self.imageOverlay.transform.isIdentity {
      rotateAffine = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    else {
      rotateAffine = CGAffineTransform.identity
    }
    
    UIView.animate(withDuration: self.rotationDuration, animations: {
      self.imageOverlay.transform = rotateAffine
    }, completion: { (complete) in
    })
    
    for view in (self.stackView.arrangedSubviews as! [MenuView]).reversed() {
      self.animateMenu(adding: view)
    }
  }
  
  var viewCounter = 0
  internal func animateMenu(adding view: MenuView) {
    
    let viewAnimationDuration = self.rotationDuration / 3.0
    let viewAnimationDelay = viewAnimationDuration * Double(viewCounter)
    UIView.animate(withDuration: viewAnimationDuration, delay: viewAnimationDelay, options: [], animations: {
      view.isHidden = false
      view.backgroundColor = UIColor.red
      view.heightConstraint.isActive = true
      view.widthConstraint.isActive = true
    }, completion: nil)
    
    viewCounter += 1
  }
  
  // MARK: Setup
  private func setupViewHierarchy() {
    self.addSubview(stackView)
    self.addSubview(imageOverlay)
  }
  
  private func configureConstraints() {
    
    self.translatesAutoresizingMaskIntoConstraints = false
    imageOverlay.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    // pin view edges to imageview edges, set to 100x100pt
    let margins = self.layoutMarginsGuide
    imageOverlay.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    imageOverlay.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    imageOverlay.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    imageOverlay.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    
    imageOverlay.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    imageOverlay.heightAnchor.constraint(equalTo: imageOverlay.widthAnchor).isActive = true
    
    // stack view
    stackView.widthAnchor.constraint(equalTo: imageOverlay.widthAnchor, multiplier: 0.75).isActive = true
    stackView.bottomAnchor.constraint(equalTo: imageOverlay.centerYAnchor).isActive = true
    stackView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
    
  }
  
  private func setupStackSubviews() {
    let viewArray: [MenuView] = [
      MenuView(frame: CGRect.zero),
      MenuView(frame: CGRect.zero),
      MenuView(frame: CGRect.zero),
      ]
    
    for view in viewArray {
      view.translatesAutoresizingMaskIntoConstraints = false
      self.stackView.addArrangedSubview(view)
      
      view.widthConstraint = view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor)
      view.heightConstraint = view.heightAnchor.constraint(equalToConstant: 80.0)
      
      view.widthConstraint.isActive = false
      view.heightConstraint.isActive = false
    }
  }
  
  // MARK: Lazy Vars
  internal lazy var imageOverlay: UIImageView = {
    let image = UIImage(named: "Octopus-Cute")
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  internal lazy var stackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = UIStackViewAlignment.fill
    stackView.distribution = UIStackViewDistribution.fillEqually
    
    return stackView
  }()
  
}
