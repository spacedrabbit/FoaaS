//
//  FoaasOperation.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal class FoaasBuilder {
  
  internal init(operation: FoaasOperation) {
    
    let components: [String] = URL(string: operation.url)!.pathComponents
    let fields = operation.fields
    
  }
  
}

internal struct FoaasField: JSONConvertible, CustomStringConvertible {
  let name: String
  let field: String
  
  var description: String {
    return "Name: \(name)   Field: \(field)"
  }
  
  init?(json: [String : AnyObject]) {
    guard
      let jName = json["name"] as? String,
      let jField = json["field"] as? String
    else { return nil }
    
    self.name = jName
    self.field = jField
  }
  
  func toJson() -> [String : AnyObject] {
    return [
      "name" : name as AnyObject,
      "field" : field as AnyObject
    ]
  }
}

internal struct FoaasOperation: JSONConvertible, DataConvertible {
  let name: String
  let url: String
  let fields: [FoaasField]
  
  // MARK: - JSONConvertible
  init?(json: [String : AnyObject]) {
    guard
      let jName = json["name"] as? String,
      let jUrl = json["url"] as? String,
      let jFields = json["fields"] as? [[String : AnyObject]]
    else { return nil }
    
    self.name = jName
    self.url = jUrl
    
    var allFields: [FoaasField] = []
    for jField in jFields {
      guard let field = FoaasField(json: jField) else { continue }
      allFields.append(field)
    }
    self.fields = allFields
  }
  
  func toJson() -> [String : AnyObject] {
    return [
      "name": self.name as AnyObject,
      "url" : self.url as AnyObject,
      "fields" : self.fields.map{ $0.toJson() } as AnyObject
    ]
  }
  
  // MARK: - Data Convertible
  init?(data: Data) {
    guard
      let json = try? JSONSerialization.jsonObject(with: data, options: []),
      let jsonValid = json as? [String : AnyObject],
      let operation = FoaasOperation(json: jsonValid)
    else {
      return nil
    }
    self = operation
  }
  
  func toData() throws -> Data {
    return try JSONSerialization.data(withJSONObject: self.toJson(), options: [])
  }

}
