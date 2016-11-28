//
//  FoaasBuilder.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum FoaasBuilderError: Error {
  case keyDoesNotExist(key: String)
  case keyIndexNotFound(key: String)
}

class FoaasBuilder {
  var operation: FoaasOperation!
  var operationFields: [String : String]!
  
  init(operation: FoaasOperation) {
    self.operation = operation
    self.operationFields = self.operation.fields.reduce( [:] ) { (current: [String:String], field: FoaasField) in
      
      var temp = current
      let fieldJson = field.toJson() as! [String : String]
      
      for (key, value) in fieldJson {
        temp[value] = key
      }
      
      return temp
      }
  }
  
  func build() -> String {
    let components = self.operation.url.components(separatedBy: "/:")
    
    let orderedComponents = components.flatMap { (component: String) -> String? in
      
      // check that its index exists to ensure it is in self.operationFields
      // check that allKeys has the component to ensure it exists in our operation
      guard let _ = self.indexOf(key: component),
        self.allKeys().contains(component)
      else { return nil }
      
      return self.operationFields[component]
    }
    
    return orderedComponents.reduce(components.first!) { (current: String, component: String) -> String in
      return "\(current)/\(component)"
    }
  }
  
  func update(key: String, value: String) throws {
    
    guard self.allKeys().contains(key) else {
      throw FoaasBuilderError.keyDoesNotExist(key: key)
    }
    
    guard let _ = indexOf(key: key) else {
      throw FoaasBuilderError.keyIndexNotFound(key: key)
    }
    
    self.operationFields[key] = value
  }
  
  func indexOf(key: String) -> Int? {
    let components = self.operation.url.components(separatedBy: "/:")
    
    let keyComponent = components.first { (component) -> Bool in
      if component == key {
        return true
      }
      return false
    }
    
    guard let locatedPosition = keyComponent else {
      return nil
    }
    
    return components.index(of: locatedPosition)
  }
  
  func allKeys() -> [String] {
    return self.operation.fields.map { $0.field }
  }
  
}
