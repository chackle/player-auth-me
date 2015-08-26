//
//  GameDetailsRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 26/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class GameDetailsRequest: PlayerMeRequest {
  
  typealias GameDetailsSuccessResponse = (games: [Game]) -> ()
  
  private var successClosure: GameDetailsSuccessResponse?
  
  override init(URL: NSURL) {
    super.init(URL: URL)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: GameDetailsSuccessResponse) -> GameDetailsRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess(games: [Game]) {
    if let success = successClosure {
      success(games: games)
    }
  }
  
  override func onFailure(response: RequestFailureResponse) -> GameDetailsRequest {
    self.failureClosure = response
    return self
  }
}
