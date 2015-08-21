//
//  WebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class WebService {
  
  typealias RequestConsumedClosure = (data: NSData) -> ()
  
  let client: Client
  let sessionService: SessionService
  
  init(client: Client, sessionService: SessionService) {
    self.client = client
    self.sessionService = sessionService
  }
  
  func prepareRequest(request: PlayerMeRequest, withParameters parameters: [String:AnyObject], andRequestType requestType: RequestType, usingSession session: Session? = nil) -> PlayerMeRequest {
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if let session = session {
      request.addValue(session.accessDetails.accessToken, forHTTPHeaderField: "Authorization")
    }
    switch (requestType) {
    case RequestType.POST:
      // POST
      var error: NSError?
      request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.allZeros, error: &error)
      if let error = error {
        request.performFailure(error)
      }
      break
    default:
      // GET
      var queryItems = [NSURLQueryItem]()
      for param in parameters {
        queryItems.append(NSURLQueryItem(name: param.0, value: "\(param.1)"))
      }
      let urlComponents = NSURLComponents(string: request.URL!.absoluteString!)!
      urlComponents.queryItems = queryItems
      request.URL = urlComponents.URL!
      break
    }
    
    return request
  }
  
  func consumeRequest(requestConsumedClosure: RequestConsumedClosure) {
    
  }
}
