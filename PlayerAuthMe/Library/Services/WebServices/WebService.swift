//
//  WebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class WebService {
  
  typealias RequestPreparedClosure = (session: NSURLSession) -> ()
  typealias RequestConsumedClosure = (data: NSData) -> ()
  
  let client: Client
  let sessionService: SessionService
  
  init(client: Client, sessionService: SessionService) {
    self.client = client
    self.sessionService = sessionService
  }
  
  func prepareRequest(requestPreparedClosure: RequestPreparedClosure) {
    
  }
  
  func consumeRequest(requestConsumedClosure: RequestConsumedClosure) {
    
  }
}
