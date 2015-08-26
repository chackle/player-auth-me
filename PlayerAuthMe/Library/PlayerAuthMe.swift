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
  func refreshAccessTokenForSession(session: Session) -> RefreshTokenRequest {
    return self.webServiceManager.refreshAccessTokenForSession(session)
  }
  
  // MARK: Get Player
  func requestPlayerWithId(id: Int) -> PlayerDetailsRequest {
    return self.webServiceManager.requestPlayerWithId(id)
  }
  
  func requestPlayerSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> PlayerDetailsRequest {
    return self.webServiceManager.requestPlayerSearch(searchQuery, andLimit: limit, andPage: page, orFrom: from)
  }
  
  func requestOnlineFollowedPlayersForSession(session: Session) -> PlayerDetailsRequest {
    return self.webServiceManager.requestOnlineFollowedPlayersForSession(session)
  }
  
  // MARK: Edit Player
  func editPlayerForSession(session: Session, withDetails details: PlayerDetailsWrapper) -> PlayerEditRequest {
    return self.webServiceManager.editPlayerForSession(session, withSessionService: sessionService, withDetails: details)
  }
  
  func editPlayerForSession(session: Session, withNewPassword password: String, andConfirmedPassword confirmedPassword: String) -> PlayerEditRequest {
    return self.webServiceManager.editPlayerForSession(session, withNewPassword: password, andConfirmedPassword: confirmedPassword)
  }
  
  func editPlayerForSession(session: Session, withAccountPrivacy privacy: AccountPrivacy) -> PlayerEditRequest {
    return self.webServiceManager.editPlayerForSession(session, withAccountPrivacy: privacy)
  }
  
  func editPlayerForSession(session: Session, withMessagingPolicy policy: MessagingPolicy) -> PlayerEditRequest {
    return self.webServiceManager.editPlayerForSession(session, withMessagingPolicy: policy)
  }
  
  func editPlayerForSession(session: Session, withOnlineVisibility visibility: OnlineVisibility) -> PlayerEditRequest {
    return self.webServiceManager.editPlayerForSession(session, withOnlineVisibility: visibility)
  }
  
  // MARK: Get Games
  func requestGameSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> GameDetailsRequest {
    return self.webServiceManager.requestGameSearch(searchQuery, andLimit: limit, andPage: page, orFrom: from)
  }
  
  func requestGameWithId(id: Int) -> GameDetailsRequest {
    return self.webServiceManager.requestGameWithId(id)
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
  
  func activeSession() -> Session? {
    return sessionService.session
  }
  
  func endSession() {
    sessionService.endSession()
  }
}
