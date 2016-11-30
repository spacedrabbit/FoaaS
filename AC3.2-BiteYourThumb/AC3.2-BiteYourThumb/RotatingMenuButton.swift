//
//  RotatingMenuButton.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class RotatingMenuButton: UIView {
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    let tapGes = UITapGestureRecognizer(target: self, action: #selector(rotateOpen))
    self.addGestureRecognizer(tapGes)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal func rotateOpen() {
    
    var rotateAffine: CGAffineTransform
    if self.transform.isIdentity {
      rotateAffine = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    else {
      rotateAffine = CGAffineTransform.identity
    }
    
    UIView.animate(withDuration: 0.40, animations: {
     self.transform = rotateAffine
    })
    
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
    
    let viewArray: [UIView] = [
      UIView(frame: CGRect.zero),
      UIView(frame: CGRect.zero),
      UIView(frame: CGRect.zero),
    ]
    
    viewArray.forEach { (view) in
      
      self.stackView.addArrangedSubview(view)
      view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
      view.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
      view.alpha = 0.0
      view.backgroundColor = UIColor.red
    }

  }
  
  internal func animateIn() {

    UIView.animate(withDuration: 2.25, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: [], animations: {
      
      for view in self.stackView.arrangedSubviews {
        view.alpha = 1.0
      }
    }
      , completion: nil)
    
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
