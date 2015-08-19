//
//  AccessDetails.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 15/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

struct AccessDetails {
  
  let accessToken: String
  let refreshToken: String
  
  private let tokenType: TokenType
  private let expires: NSDate
  private let expiresIn: NSTimeInterval
  
  init(accessToken: String, refreshToken: String, tokenType: TokenType, expires: NSDate, expiresIn: NSTimeInterval) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    self.tokenType = tokenType
    self.expires = expires
    self.expiresIn = expiresIn
  }
  
  init(accessToken: String, refreshToken: String, tokenType: String, expires: NSDate, expiresIn: NSTimeInterval) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    if let tokenType = TokenType(rawValue: tokenType) {
      self.tokenType = tokenType
    } else {
      self.tokenType = TokenType.Invalid
    }
    self.expires = expires
    self.expiresIn = expiresIn
  }
  
  func toDictionary() -> [String:AnyObject] {
    return [
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "tokenType": tokenType.rawValue,
      "expires": expires,
      "expiresIn": expiresIn
    ]
  }
}
