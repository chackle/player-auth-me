//
//  PlayerMeRequest.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 15/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerMeRequest: NSMutableURLRequest {
  
  typealias RequestFailureResponse = (error: NSError) -> ()
  
  var failureClosure: RequestFailureResponse?
  
  private let kDefaultTimeoutInterval: NSTimeInterval = 60
  
  override init(URL: NSURL, cachePolicy: NSURLRequestCachePolicy, timeoutInterval: NSTimeInterval) {
    super.init(URL: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
  }
  
  init(URL: NSURL) {
    super.init(URL: URL, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: kDefaultTimeoutInterval)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func onFailure(response: RequestFailureResponse) -> PlayerMeRequest {
    self.failureClosure = response
    return self
  }
  
  func performFailure(error: NSError) {
    if let failure = failureClosure {
      failure(error: error)
    }
  }
}
