//
//  FoaasDataManager.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal class FoaasDataManager {
  private static let operationsKey: String = "FoaasOperationsKey"
  private var operations: [FoaasOperation]?
  
  internal static let shared: FoaasDataManager = FoaasDataManager()
  private init () { }
  
  internal func save(operations: [FoaasOperation]) {
    let defaults = UserDefaults.standard
    
    let opsData = operations.map{ $0.asData() }
    defaults.set(opsData, forKey: FoaasDataManager.operationsKey)
  }
  
  internal func load() -> Bool {
    let defaults = UserDefaults.standard
    
    guard
      let opsData = defaults.object(forKey: FoaasDataManager.operationsKey) as? [Data]
    else { return false }
    
    self.operations = opsData.flatMap { FoaasOperation(data: $0) }
    return true
  }
  
}
