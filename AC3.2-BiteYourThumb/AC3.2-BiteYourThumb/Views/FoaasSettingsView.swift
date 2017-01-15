//
//  FoaasSettingsView.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 1/14/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FoaasSettingsView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  internal func setupViewHierarchy() {
    self.backgroundColor = .white
    
    self.addSubview(colorPaletteLabel)
    self.addSubview(profinityFilterLabel)
    
    self.addSubview(profanitySwitch)
    self.addSubview(onLabel)
    self.addSubview(offLabel)
    
    self.addSubview(authorInfoLabel)
    self.addSubview(versionNumberLabel)
  }
  
  internal func configureConstraints() {
    let _ = [ self,
              colorPaletteLabel,
              profinityFilterLabel,
              profanitySwitch,
              onLabel,
              offLabel,
              authorInfoLabel,
              versionNumberLabel,
      ].map{ $0.translatesAutoresizingMaskIntoConstraints = false }
    
    let _ = [
      // colorPaletteLabelConstraints
      colorPaletteLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
      colorPaletteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
      
      // profanityLabelConstraints
      profinityFilterLabel.topAnchor.constraint(equalTo: colorPaletteLabel.bottomAnchor, constant: 8.0),
      profinityFilterLabel.leadingAnchor.constraint(equalTo: colorPaletteLabel.leadingAnchor),
      
      // authorLabelConstraints
      authorInfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
      authorInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      
      //versionInfoConstraints
      versionNumberLabel.bottomAnchor.constraint(equalTo: authorInfoLabel.topAnchor, constant: -8.0),
      versionNumberLabel.centerXAnchor.constraint(equalTo: authorInfoLabel.centerXAnchor),
      
      // TODO: remove this spacing constraint
      versionNumberLabel.topAnchor.constraint(equalTo: profinityFilterLabel.bottomAnchor, constant: 64.0),

    ].map{ $0.isActive = true }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal lazy var colorPaletteLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "COLOR PALETTE"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var profinityFilterLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "PROFANITY"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var onLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "ON"
    label.textAlignment = .left
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var offLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "OFF"
    label.textAlignment = .left
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightLight)
    return label
  }()
  
  internal lazy var profanitySwitch: UISwitch = {
    let profanitySwitch: UISwitch = UISwitch()
    // TODO: make tint color based on color manager settings
    // TODO: set isON based on settings manager
    return profanitySwitch
  }()
  
  internal lazy var versionNumberLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "V 0.1.0"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    label.textColor = .gray
    return label
  }()
  
  internal lazy var authorInfoLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "MADE WITH ❤️ LOUIS.TUR@GMAIL.COM"
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
    label.textColor = .gray
    return label
  }()
}

