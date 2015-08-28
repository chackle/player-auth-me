//
//  FeedRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class FeedRequest: PlayerMeRequest {
  
  typealias FeedSuccessResponse = (posts: [FeedPost]) -> ()
  
  private var successClosure: FeedSuccessResponse?
  
  override init(URL: NSURL) {
    super.init(URL: URL)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onSuccess(response: FeedSuccessResponse) -> FeedRequest {
    self.successClosure = response
    return self
  }
  
  func performSuccess(posts: [FeedPost]) {
    if let success = successClosure {
      success(posts: posts)
    }
  }
  
  override func onFailure(response: RequestFailureResponse) -> FeedRequest {
    self.failureClosure = response
    return self
  }
}
