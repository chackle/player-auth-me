//
//  WebServiceManager.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 14/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class WebServiceManager {
  
  private let client: Client
  private let sessionService: SessionService
  
  // Web Services
  let authenticationService: AuthenticationService
  
  init(client: Client, sessionService: SessionService) {
    self.client = client
    self.sessionService = sessionService
    self.authenticationService = AuthenticationService(client: self.client, sessionService: self.sessionService)
  }
}
