//
//  PlayerDetailsRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerDetailsRequest: PlayerMeRequest {
  
  typealias PlayerDetailsSuccessResponse = (players: [Player]) -> ()
  typealias PlayerDetailsFailureResponse = (error: NSError) -> ()
  
  private var successClosure: PlayerDetailsSuccessResponse?
  private var failureClosure: PlayerDetailsFailureResponse?
  
  override init(URL: NSURL) {
    super.init(URL: URL)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: PlayerDetailsSuccessResponse) -> PlayerDetailsRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess(players: [Player]) {
    if let success = successClosure {
      success(players: players)
    }
  }
  
  func onFailure(response: PlayerDetailsFailureResponse) -> PlayerDetailsRequest {
    self.failureClosure = response
    return self
  }
  
  func performFailure(error: NSError) {
    if let failure = failureClosure {
      failure(error: error)
    }
  }
}
