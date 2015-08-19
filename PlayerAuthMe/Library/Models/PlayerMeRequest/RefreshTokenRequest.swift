//
//  RefreshTokenRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 17/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class RefreshTokenRequest: PlayerMeRequest {
  
  typealias RefreshSuccessResponse = () -> ()
  typealias RefreshFailureResponse = (error: NSError) -> ()
  
  private var successClosure: RefreshSuccessResponse?
  private var failureClosure: RefreshFailureResponse?
  
  override init(URL: NSURL) {
    super.init(URL: URL)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: RefreshSuccessResponse) -> RefreshTokenRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess() {
    if let success = successClosure {
      success()
    }
  }
  
  func onFailure(response: RefreshFailureResponse) -> RefreshTokenRequest {
    self.failureClosure = response
    return self
  }
  
  func performFailure() {
    if let failure = failureClosure {
      failure(error: NSError())
    }
  }
}