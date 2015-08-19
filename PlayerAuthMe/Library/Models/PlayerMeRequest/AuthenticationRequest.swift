//
//  AuthenticationRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 15/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class AuthenticationRequest: PlayerMeRequest {
  
  typealias AuthSuccessResponse = (result: AccessDetails) -> ()
  typealias AuthFailureResponse = (error: NSError) -> ()
  
  private var successClosure: AuthSuccessResponse?
  private var failureClosure: AuthFailureResponse?
  
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
  
  func performSuccess(result: AccessDetails) {
    if let success = successClosure {
      success(result: result)
    }
  }
  
  func onFailure(response: AuthFailureResponse) -> AuthenticationRequest {
    self.failureClosure = response
    return self
  }
  
  func performFailure() {
    if let failure = failureClosure {
      failure(error: NSError())
    }
  }
}
