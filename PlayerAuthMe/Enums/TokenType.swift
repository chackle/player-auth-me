//
//  TokenType.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 15/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

enum TokenType: String {
  // MARK: TODO - Flesh out with more tokenTypes
  case Bearer = "bearer"
  case Invalid = "invalid"
  
  static let allValues = [Bearer]
  static let allRawValues = ["bearer"]
}