//
//  FoaasManager.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum FoaasType {
  case awesome(from: String)
  case bag(from: String)
  case bye(from: String)
}

internal class FoaasManager {
  
  private static let debugURL = URL(string: "https://www.foaas.com/awesome/louis")!
  
  internal class func getFoaas(url: URL = FoaasManager.debugURL, completion: @escaping (Foaas?)->Void) {
    
    var request: URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
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
}

/*
 /awesome/:from	Will return content of the form 'This is Fucking Awesome. - :from'
 /back/:name/:from	Will return content of the form ':name, back the fuck off. - :from'
 /bag/:from	Will return content of the form 'Eat a bag of fucking dicks. - :from'
 /ballmer/:name/:company/:from	Will return content of the form 'Fucking :name is a fucking pussy. I'm going to fucking bury that guy, I have done it before, and I will do it again. I'm going to fucking kill :company. - :from'
 /bday/:name/:from	Will return content of the form 'Happy Fucking Birthday, :name. - :from'
 /because/:from	Will return content of the form 'Why? Because fuck you, that's why. - :from'
 /blackadder/:name/:from	Will return content of the form ':name, your head is as empty as a eunuch’s underpants. Fuck off! - :from'
 /bm/:name/:from	Will return content of the form 'Bravo mike, :name. - :from'
 /bucket/:from	Will return content of the form 'Please choke on a bucket of cocks. - :from'
 /bus/:name/:from	Will return content of the form 'Christ on a bendy-bus, :name, don't be such a fucking faff-arse. - :from'
 /bye/:from	Will return content of the form 'Fuckity bye! - :from'
 /caniuse/:tool/:from	Will return content of the form 'Can you use :tool? Fuck no! - :from'
 /chainsaw/:name/:from	Will return content of the form 'Fuck me gently with a chainsaw, :name. Do I look like Mother Teresa? - :from'
 /cocksplat/:name/:from	Will return content of the form 'Fuck off :name, you worthless cocksplat - :from'
 /cool/:from	Will return content of the form 'Cool story, bro. - :from'
 /dalton/:name/:from	Will return content of the form ':name: A fucking problem solving super-hero. - :from'
 /deraadt/:name/:from	Will return content of the form ':name you are being the usual slimy hypocritical asshole... You may have had value ten years ago, but people will see that you don't anymore. - :from'
 /diabetes/:from	Will return content of the form 'I'd love to stop and chat to you but I'd rather have type 2 diabetes. - :from'
 /donut/:name/:from	Will return content of the form ':name, go and take a flying fuck at a rolling donut. - :from'
 /dosomething/:do/:something/:from	Will return content of the form ':do the fucking :something! - :from'
 /everyone/:from	Will return content of the form 'Everyone can go and fuck off. - :from'
 /everything/:from	Will return content of the form 'Fuck everything. - :from'
 */
