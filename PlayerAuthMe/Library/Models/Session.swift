//
//  Session.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class Session {
  
  var player: Player
  var accessDetails: AccessDetails
  
  init(player: Player, accessDetails: AccessDetails) {
    self.player = player
    self.accessDetails = accessDetails
  }
  
  func toDictionary() -> [String:AnyObject] {
    return [
      "player": player.toDictionary(),
      "accessDetails": accessDetails.toDictionary()
    ]
  }
}
