//
//  AuthenticationRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 15/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class AuthenticationRequest: PlayerMeRequest {
  
  typealias AuthSuccessResponse = (result: Player) -> ()
  
  private var successClosure: AuthSuccessResponse?
  
  override init(URL: NSURL) {
    super.init(URL: URL)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: AuthSuccessResponse) -> AuthenticationRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess(result: Player) {
    if let success = successClosure {
      success(result: result)
    }
  }
  
  override func onFailure(response: RequestFailureResponse) -> AuthenticationRequest {
    self.failureClosure = response
    return self
  }
}
