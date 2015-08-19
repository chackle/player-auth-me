//
//  WebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class WebService {
  
  let client: Client
  let sessionService: SessionService
  
  init(client: Client, sessionService: SessionService) {
    self.client = client
    self.sessionService = sessionService
  }
  
  func currentAccessToken() -> String {
    if let accessToken = sessionService.session?.accessDetails.accessToken {
      return accessToken
    } else {
      println("*** accessToken is empty or session is == nil. A valid accessToken must be used to make OAuth requests ***")
      return ""
    }
  }
  
  func currentRefreshToken() -> String {
    if let refreshToken = sessionService.session?.accessDetails.refreshToken {
      return refreshToken
    } else {
      println("*** refreshToken is empty or session is == nil. A valid refreshToken must be used to refresh OAuth session ***")
      return ""
    }
  }
}
