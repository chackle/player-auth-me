//
//  RequestType.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 21/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

enum RequestType: String {
  
  case GET = "GET"
  case POST = "POST"
  case PUT = "PUT"
  
  static let allValues = [GET, POST, PUT]
  static let allRawValues = [GET.rawValue, POST.rawValue, PUT.rawValue]
}
