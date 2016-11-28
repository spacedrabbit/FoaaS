//
//  FoaasAPIManager.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

protocol FoaasAPIManagerDelegate: class {
  func didFinishOperationsRequest(data: Data)
  func didFinishFoaasRequest(data: Data)
}

internal class FoaasAPIManager {
  private static let backgroundSessionIdentifier: String = "foaasBackgroundSession"
  
  private static let debugURL = URL(string: "https://www.foaas.com/awesome/louis")!
  private static let extendedDebugURL = URL(string: "https://www.foaas.com/greed/cat/louis")!
  private static let extendedTwoDebugURL = URL(string: "https://www.foaas.com/madison/louis/paul")!
  private static let operationsURL = URL(string: "https://www.foaas.com/operations")!
  
  private static let defaultSession = URLSession(configuration: .default)
  internal private(set) weak static var delegate: FoaasAPIManagerDelegate?
  
  internal class func getFoaas(url: URL = FoaasAPIManager.extendedTwoDebugURL, completion: @escaping (Foaas?)->Void) {
    
    var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    defaultSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
      print("Session returning data")
      
      
      
      if error != nil {
        print("Error encountered: \(error!)")
      }
      
      if data != nil {
        
        do {
          let foaasJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
          
          guard
            let validFoaas = foaasJson,
            let newFoaas = Foaas(json: validFoaas)
          else {
            completion(nil)
            return
          }
          
          completion(newFoaas)
        }
        catch {
          print("There was an error parsing data: \(error)")
        }
        
      }
    
    }).resume()
    print("Starting Call")
  }
  
  internal class func getOperations(completion: @escaping ([FoaasOperation]?)->Void ) {
    
    defaultSession.dataTask(with: FoaasAPIManager.operationsURL, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
      
      if error != nil {
        print("Error: \(error.unsafelyUnwrapped)")
      }
      
      if data != nil {
        
        do {
          guard let operationsJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any] else {
            return
          }
          
          var operations: [FoaasOperation] = []
          for case let operation as [String : AnyObject] in operationsJson {
            guard let foaasOp = FoaasOperation(json: operation) else { continue }
            operations.append(foaasOp)
          }
          
          completion(operations)
        }
        catch {
          print("Error attempting to deserialize operations json: \(error)")
        }
  
      }
    }).resume()
   
  }
  
  internal class func assignDelegate(_ delegate: FoaasAPIManagerDelegate) {
    self.delegate = delegate
  }
  
  

}
