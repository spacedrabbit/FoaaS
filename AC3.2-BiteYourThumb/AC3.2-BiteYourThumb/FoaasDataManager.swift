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
  private static let defaults = UserDefaults.standard
  internal private(set) var operations: [FoaasOperation]?
  
  // MARK: Singleton
  internal static let shared: FoaasDataManager = FoaasDataManager()
  private init () {
  }
  
  internal func requestOperations(_ operations: @escaping ([FoaasOperation]?)->Void) {
    
    if self.load() {
      operations(self.operations!)
      return
    }
    
    FoaasAPIManager.getOperations { (apiOperations: [FoaasOperation]?) in
      operations(apiOperations)
      
      guard apiOperations != nil else {
        return
      }
      self.save(operations: apiOperations!)
    }
  }
  
  
  internal class func requestPreview(for operation: FoaasOperation, completion: @escaping (Foaas?)->Void ) {
    
  }
  
  // MARK: - Save/Load
  private func save(operations: [FoaasOperation]) {
    self.operations = operations
    let opsData = operations.flatMap{ try? $0.toData() }
    
    print("Successful conversion of [FoaasOperation] to [Data]. Storing...")
    FoaasDataManager.defaults.set(opsData, forKey: FoaasDataManager.operationsKey)
  }
  
  private func load() -> Bool {
    guard
      let opsData = FoaasDataManager.defaults.object(forKey: FoaasDataManager.operationsKey) as? [Data]
    else { return false }
    
    print("Found [Data], converting to FoaasOperation")
    self.operations = opsData.flatMap { FoaasOperation(data: $0) }
    return true
  }
  
  // MARK: - Delete
  internal func deleteStoredOperations() {
    guard self.load() else {
      return
    }
    
    print("Deleting stored [FoaasOperation]")
    FoaasDataManager.defaults.removeObject(forKey: FoaasDataManager.operationsKey)
    self.operations = nil
  }
  
}
