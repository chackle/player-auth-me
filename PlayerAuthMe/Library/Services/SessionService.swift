//
//  SessionService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 17/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class SessionService {
  
  let storageService: PersistentStorageService
  
  var session: Session?
  
  init() {
    self.storageService = PersistentStorageService()
    self.session = self.storageService.loadCurrentSession()
  }
  
  func startSession(player: Player, accessDetails: AccessDetails) {
    session = Session(player: player, accessDetails: accessDetails)
    storageService.storeCurrentSession(session!)
  }
  
  func updateSession(accessDetails: AccessDetails) {
    if let currentSession = session {
      currentSession.accessDetails = accessDetails
      self.storageService.storeCurrentSession(currentSession)
    }
  }
  
  func updateSession(playerDetails: PlayerDetailsWrapper) {
    if let session = session {
      if let username = playerDetails.username {
        session.player.username = username
      }
      if let longDescription = playerDetails.longDescription {
        session.player.longDescription = longDescription
      }
      self.storageService.storeCurrentSession(session)
    }
  }
  
  func endSession() {
    storageService.clearCurrentSession()
    session = nil
  }
}
