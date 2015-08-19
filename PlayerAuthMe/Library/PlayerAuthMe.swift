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
  
  // MARK: Authentication
  func authenticateUser(username: String, withPassword password: String) -> AuthenticationRequest {
    return self.webServiceManager.authenticateUser(username, withPassword: password)
  }
  
  // MARK: Session
  func refreshAccessTokenForCurrentSession() -> RefreshTokenRequest {
    return self.webServiceManager.refreshAccessTokenForCurrentSession()
  }
  
  // MARK: Player
  func requestPlayerWithId(id: Int) -> PlayerDetailsRequest {
    return self.webServiceManager.requestPlayerWithId(id)
  }
  
  func requestPlayerSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> PlayerDetailsRequest {
    return self.webServiceManager.requestPlayerSearch(searchQuery, andLimit: limit, andPage: page, orFrom: from)
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
