//
//  FoaasTemplate.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/17/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct FoaasKey {
  internal static let from: String = "from"
  internal static let company: String = "company"
  internal static let tool: String = "tool"
  internal static let name: String = "name"
  internal static let doAction: String = "do"
  internal static let something: String = "something"
  internal static let thing: String = "thing"
  internal static let behavior: String = "behavior"
  internal static let language: String = "language"
  internal static let reaction: String = "reaction"
  internal static let noun: String = "noun"
  internal static let reference: String = "reference"
}

internal struct FoaasTemplate {
  let from: String
  let company: String? = nil
  let tool: String? = nil
  let name: String? = nil
  let doAction: String? = nil
  let something: String? = nil
  let thing: String? = nil
  let behavior: String? = nil
  let language: String? = nil
  let reaction: String? = nil
  let noun: String? = nil
  let reference: String? = nil
}

extension FoaasTemplate: JSONable {
  init?(json: [String : AnyObject]) {
    
    guard let jFrom = json[FoaasKey.from] as? String else {
      return nil
    }
    
    self.from = jFrom
    
    
  }
  
  func toJson() -> [String : AnyObject] {
    return [:]
  }
}
