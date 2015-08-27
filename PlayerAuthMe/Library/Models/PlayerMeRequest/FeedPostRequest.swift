//
//  FeedPostRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 27/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class FeedPostRequest: PlayerMeRequest {
  
  typealias FeedPostSuccessResponse = () -> ()
  
  private var successClosure: FeedPostSuccessResponse?
  
  override init(URL: NSURL) {
    super.init(URL: URL)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: FeedPostSuccessResponse) -> FeedPostRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess() {
    if let success = successClosure {
      success()
    }
  }
  
  override func onFailure(response: RequestFailureResponse) -> FeedPostRequest {
    self.failureClosure = response
    return self
  }
}
