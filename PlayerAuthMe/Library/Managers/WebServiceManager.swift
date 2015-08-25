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
  let authenticationWebService: AuthenticationWebService
  let playerWebService: PlayerWebService
  
  init(client: Client, sessionService: SessionService) {
    self.client = client
    self.sessionService = sessionService
    self.authenticationWebService = AuthenticationWebService(client: self.client, sessionService: self.sessionService)
    self.playerWebService = PlayerWebService(client: self.client, sessionService: self.sessionService)
  }
  
  // MARK: Authentication Requests
  func authenticateUser(username: String, withPassword password: String) -> AuthenticationRequest {
    return self.authenticationWebService.loginWithUsername(username, andPassword: password, andPlayerWebService: self.playerWebService)
  }
  
  // MARK: Session Renewal Requests
  func refreshAccessTokenForSession(session: Session) -> RefreshTokenRequest {
    return self.authenticationWebService.refreshAccessTokenForSession(session)
  }
  
  // MARK: Player Details Requests
  func requestPlayerWithId(id: Int) -> PlayerDetailsRequest {
    return self.playerWebService.requestPlayerWithId(id)
  }
  
  func requestPlayerSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> PlayerDetailsRequest {
    return self.playerWebService.requestPlayerSearch(searchQuery, andLimit: limit, andPage: page, orFrom: from)
  }
  
  func requestOnlineFollowedPlayersForSession(session: Session) -> PlayerDetailsRequest {
    return self.playerWebService.requestOnlineFollowedPlayersForSession(session)
  }
  
  // MARK: Player Edit Requests
  func requestToEditPlayerForSession(session: Session, withDetails details: PlayerDetailsWrapper) -> PlayerEditRequest {
    return self.playerWebService.requestToEditPlayerForSession(session, withDetails: details)
  }
  
  func requestToEditPlayerForSession(session: Session, withNewPassword password: String, andConfirmedPassword confirmedPassword: String) -> PlayerEditRequest {
    return self.playerWebService.requestToEditPlayerForSession(session, withNewPassword: password, andConfirmedPassword: confirmedPassword)
  }
  
  func requestToEditPlayerForSession(session: Session, withAccountPrivacy privacy: AccountPrivacy) -> PlayerEditRequest {
    return self.playerWebService.requestToEditPlayerForSession(session, withAccountPrivacy: privacy)
  }
  
  func requestToEditPlayerForSession(session: Session, withMessagingPolicy policy: MessagingPolicy) -> PlayerEditRequest {
    return self.playerWebService.requestToEditPlayerForSession(session, withMessagingPolicy: policy)
  }
  
  func requestToEditPlayerForSession(session: Session, withOnlineVisibility visibility: OnlineVisibility) -> PlayerEditRequest {
    return self.playerWebService.requestToEditPlayerForSession(session, withOnlineVisibility: visibility)
  }
}
