//
//  Protocols.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

protocol JSONConvertible {
  init?(json: [String : AnyObject])
  func toJson() -> [String : AnyObject]
}

protocol DataConvertible {
  init?(data: Data)
  func toData() throws -> Data
}
