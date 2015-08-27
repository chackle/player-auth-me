//
//  WebServiceManager.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 14/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class WebServiceManager {
  
  private let client: Client
  private let sessionService: SessionService
  
  // Web Services
  let authenticationWebService: AuthenticationWebService
  let playerWebService: PlayerWebService
  let gameWebService: GameWebService
  let feedWebService: FeedWebService
  
  init(client: Client, sessionService: SessionService) {
    self.client = client
    self.sessionService = sessionService
    self.authenticationWebService = AuthenticationWebService(client: self.client, sessionService: self.sessionService)
    self.playerWebService = PlayerWebService(client: self.client, sessionService: self.sessionService)
    self.gameWebService = GameWebService(client: self.client, sessionService: self.sessionService)
    self.feedWebService = FeedWebService(client: self.client, sessionService: self.sessionService)
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
  func editPlayerForSession(session: Session, withSessionService sessionService: SessionService? = nil, withDetails details: PlayerDetailsWrapper) -> PlayerEditRequest {
    return self.playerWebService.editPlayerForSession(session, withSessionService: sessionService, withDetails: details)
  }
  
  func editPlayerForSession(session: Session, withNewPassword password: String, andConfirmedPassword confirmedPassword: String) -> PlayerEditRequest {
    return self.playerWebService.editPlayerForSession(session, withNewPassword: password, andConfirmedPassword: confirmedPassword)
  }
  
  func editPlayerForSession(session: Session, withAccountPrivacy privacy: AccountPrivacy) -> PlayerEditRequest {
    return self.playerWebService.editPlayerForSession(session, withAccountPrivacy: privacy)
  }
  
  func editPlayerForSession(session: Session, withMessagingPolicy policy: MessagingPolicy) -> PlayerEditRequest {
    return self.playerWebService.editPlayerForSession(session, withMessagingPolicy: policy)
  }
  
  func editPlayerForSession(session: Session, withOnlineVisibility visibility: OnlineVisibility) -> PlayerEditRequest {
    return self.playerWebService.editPlayerForSession(session, withOnlineVisibility: visibility)
  }
  
  // MARK: Game Requests
  func requestGameSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> GameDetailsRequest {
    return self.gameWebService.requestGameSearch(searchQuery, andLimit: limit, andPage: page, orFrom: from)
  }
  
  // MARK: Feed Requests
  func postToFeedUsingSession(session: Session, withText text: String, andImages images: [UIImage]? = nil, andCheckInGameId gameId: Int? = nil) -> FeedPostRequest {
    return self.feedWebService.postToFeedUsingSession(session, withText: text, andImages: images, andCheckInGameId: gameId)
  }
  
  func requestGameWithId(id: Int) -> GameDetailsRequest {
    return self.gameWebService.requestGameWithId(id)
  }
}
