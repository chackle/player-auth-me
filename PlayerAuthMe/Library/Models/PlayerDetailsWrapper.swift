//
//  PlayerDetailsWrapper.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 24/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerDetailsWrapper {
  
  private var username: String?
  private var email: String?
  private var longDescription: String?
  private var accountType: AccountType?
  
  init() {
    
  }
  
  func changeUsername(username: String) -> PlayerDetailsWrapper {
    self.username = username
    return self
  }
  
  func changeEmail(email: String) -> PlayerDetailsWrapper {
    self.email = email
    return self
  }
  
  func changeLongDescription(longDescription: String) -> PlayerDetailsWrapper {
    self.longDescription = longDescription
    return self
  }
  
  func changeAccountType(accountType: AccountType) -> PlayerDetailsWrapper {
    self.accountType = accountType
    return self
  }
  
  func toDictionary() -> [String:AnyObject] {
    var parameters = [String:AnyObject]()
    if let username = username {
      parameters["username"] = username
    }
    if let email = email {
      parameters["email"] = email
    }
    if let longDescription = longDescription {
      parameters["description"] = longDescription
    }
    if let accountType = accountType {
      parameters["account_type"] = accountType.rawValue
    }
    return parameters
  }
}
