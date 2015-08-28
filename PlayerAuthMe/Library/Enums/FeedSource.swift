//
//  FeedSource.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

enum FeedSource: String {
  
  case PlayerMe = "playerme"
  case Youtube = "youtube"
  case Twitch = "twitch"
  
  static let allValues = [PlayerMe, Youtube, Twitch]
  static let allRawValues = [PlayerMe.rawValue, Youtube.rawValue, Twitch.rawValue]
}
