//
//  PlayerEditRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 24/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerEditRequest: PlayerMeRequest {
  
  typealias PlayerEditSuccessResponse = () -> ()
  
  private var successClosure: PlayerEditSuccessResponse?
  
  var parameters: [String:AnyObject]
  
  override init(URL: NSURL) {
    self.parameters = [String:AnyObject]()
    super.init(URL: URL)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: PlayerEditSuccessResponse) -> PlayerEditRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess() {
    if let success = successClosure {
      success()
    }
  }
  
  override func onFailure(response: RequestFailureResponse) -> PlayerEditRequest {
    self.failureClosure = response
    return self
  }
}