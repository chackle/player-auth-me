//
//  AccountType.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 24/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

enum AccountType: String {
  
  case User = "user"
  case Group = "group"
  
  static let allValues = [User, Group]
  static let allRawValues = [User.rawValue, Group.rawValue]
}