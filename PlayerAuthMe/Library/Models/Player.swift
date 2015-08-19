//
//  Player.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 17/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class Player {
  
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
  func toDictionary() -> [String:AnyObject] {
    return [
      "name": name
    ]
  }
}
