//
//  SlidingTextField.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 12/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

enum SlideDirection {
  case up, down
}

class SlidingTextField: UIView, UITextFieldDelegate {
  internal final var textField: UITextField!
  internal final var textLabel: UILabel!
  private final var touchIntercept: UIControl!
  
  private var labelEmptyConstraint: NSLayoutConstraint!
  private var labelFilledConstraint: NSLayoutConstraint!
  
  // MARK: - Drawing
  override func draw(_ rect: CGRect) {
    let lineWidth: CGFloat = 2.0
    
    let startPoint = CGPoint(x: 0.0, y: rect.height - lineWidth)
    let endPoint = CGPoint(x: rect.width, y: rect.height - lineWidth)
    
    let context = UIGraphicsGetCurrentContext()
    context?.setLineWidth(2.0)
    context?.setStrokeColor(UIColor.red.cgColor)
    context?.move(to: startPoint)
    context?.addLine(to: endPoint)
    
    context?.strokePath()
  }
  
  
  // MARK: - Initialization
  convenience init(placeHolderText: String) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = .clear
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - View Setup
  private func configureConstraints() {
    self.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    touchIntercept.translatesAutoresizingMaskIntoConstraints = false
    
    self.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    
    touchIntercept.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    touchIntercept.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    touchIntercept.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    touchIntercept.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    // label left/right
    textLabel.leadingAnchor.constraint(equalTo: self.textField.leadingAnchor, constant: 2.0).isActive = true
    textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
    
    // label empty text state
    labelEmptyConstraint = textLabel.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor, constant: 0.0)
    labelEmptyConstraint.isActive = true

    // label non-empty text state
    labelFilledConstraint = textLabel.bottomAnchor.constraint(equalTo: self.textField.topAnchor, constant: 0.0)
    labelFilledConstraint.isActive = false
    
    // textfield
    textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
    textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0).isActive = true
    textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
  private func setupViewHierarchy() {
    textLabel = UILabel()
    textLabel.text = "TEXT LABEL"
    
    textField = UITextField()
    textField.borderStyle = .none
    textField.placeholder = ""
    textField.delegate = self
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .words
    
    
    touchIntercept = UIControl()
    touchIntercept.backgroundColor = UIColor.blue.withAlphaComponent(0.25)
    touchIntercept.addTarget(self, action: #selector(didTapSlidingTextView(sender:)), for: .touchDown)
    
    // TODO: remove tounc intercept entirely
    self.addSubview(touchIntercept)
    self.addSubview(textLabel)
    self.addSubview(textField)
    
  }
  
  private func textFieldHasText() -> Bool {
    guard
      let textFieldText = textField.text,
      !textFieldText.isEmpty
    else {
        return false
    }
    
    return true
  }
  
  // MARK: - TextField Delegate
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    slideLabel(direction: .up)
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
    guard textFieldHasText() else {
      slideLabel(direction: .down)
      return
    }
    
    slideLabel(direction: .up)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
  
  // MARK: - Helpers
  private func slideLabel(direction: SlideDirection) {
    switch direction {
    case .up:
      self.labelFilledConstraint.isActive = true
      self.labelEmptyConstraint.isActive = false
    case .down:
      self.labelFilledConstraint.isActive = false
      self.labelEmptyConstraint.isActive = true
    }
    
    UIView.animate(withDuration: 0.2, animations: {
      self.layoutIfNeeded()
    })
  }

  // MARK: - Actions
  @objc private func didTapSlidingTextView(sender: UIGestureRecognizer) {
    print("did tap me")
  }
  
}
