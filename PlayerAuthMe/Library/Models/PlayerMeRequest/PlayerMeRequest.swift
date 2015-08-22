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
  typealias RequestCompletionHandler = ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)
  
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
  
  func prepare(requestType: RequestType, withParameters parameters: [String:AnyObject]? = nil,  usingSession session: Session?) {
    self.prepare(requestType, withParameters: parameters)
    if let session = session {
      self.addValue(session.accessDetails.accessToken, forHTTPHeaderField: "Authorization")
    }
  }
  
  func startWithCompletionHandler(completionHandler: RequestCompletionHandler) {
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(self, completionHandler: completionHandler)
    task.resume()
  }
  
  func prepare(requestType: RequestType, withParameters parameters: [String:AnyObject]? = nil) {
    self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    self.HTTPMethod = requestType.rawValue
    switch (requestType) {
    case RequestType.POST:
      // POST
      if let params = parameters {
        var error: NSError?
        self.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.allZeros, error: &error)
        if let error = error {
          self.performFailure(error)
        }
      }
      break
    default:
      // GET
      if let params = parameters {
        var queryItems = [NSURLQueryItem]()
        for param in params {
          queryItems.append(NSURLQueryItem(name: param.0, value: "\(param.1)"))
        }
        let urlComponents = NSURLComponents(string: self.URL!.absoluteString!)!
        urlComponents.queryItems = queryItems
        self.URL = urlComponents.URL!
      }
      break
    }
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
