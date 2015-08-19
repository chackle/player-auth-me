//
//  PlayerAuthMe.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 14/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerAuthMe {
  
  static let sharedInstance = PlayerAuthMe()
  
  private let client: Client
  private let webServiceManager: WebServiceManager
  private let sessionService: SessionService
  
  private init() {
    // Hide init. We want to init from the shared sharedInstance
    self.client = Client()
    self.sessionService = SessionService()
    self.webServiceManager = WebServiceManager(client: self.client, sessionService: self.sessionService)
  }
  
  func authenticateUser(username: String, withPassword password: String) -> AuthenticationRequest {
    return self.webServiceManager.authenticationService.loginWithUsername(username, andPassword: password)
  }
  
  func refreshAccessTokenForCurrentSession() -> RefreshTokenRequest {
    return self.webServiceManager.authenticationService.refreshAccessTokenForCurrentSession()
  }
  
  func currentPlayer() -> Player? {
    return self.sessionService.session?.player
  }
  
  func clientId(id: String) {
    self.client.id = id
  }
  
  func clientId() -> String {
    if self.client.id == "" {
      println("*** clientId is empty. A valid clientId must be set before using OAuth services ***")
    }
    return self.client.id
  }
  
  func clientSecret(secret: String) {
    self.client.secret = secret
  }
  
  func clientSecret() -> String {
    if self.client.secret == "" {
      println("*** clientSecret is empty. A valid clientSecret must be set before using OAuth services ***")
    }
    return self.client.secret
  }
}
