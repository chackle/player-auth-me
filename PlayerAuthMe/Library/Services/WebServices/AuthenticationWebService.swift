//
//  AuthenticationWebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 14/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class AuthenticationWebService: WebService {
  
  func loginWithUsername(username: String, andPassword password: String, andPlayerWebService playerWebService: PlayerWebService) -> AuthenticationRequest {
    let parameters = [
      "grant_type": "password",
      "client_id": client.id,
      "client_secret": client.secret,
      "username": username,
      "password": password,
    ]
    let url = NSURL(string: "\(kPlayerMeApiBaseHost)/oauth/access_token")!
    var err: NSError?
    let request = AuthenticationRequest(URL: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPMethod = "POST"
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.allZeros, error: &err)
    
    if err != nil {
      // implement
    }
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
      
      if error != nil {
        // Replace error with meaningful NSError
        request.performFailure(error)
      }
      
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let refreshToken = decodedJson["refresh_token"] as? String,
        tokenTypeString = decodedJson["token_type"] as? String,
        tokenType = TokenType(rawValue: tokenTypeString),
        accessToken = decodedJson["access_token"] as? String,
        expiresInterval = decodedJson["expires"] as? Double,
        expiresIn = decodedJson["expires_in"] as? Double {
          let expires = NSDate(timeIntervalSince1970: expiresInterval)
          let accessDetails = AccessDetails(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType, expires: expires, expiresIn: expiresIn)
          playerWebService.requestCurrentPlayer()
          .onSuccess({ (players) -> () in
            if players.count == 1 {
              let currentPlayer = players[0]
              self.sessionService.startSession(currentPlayer, accessDetails: accessDetails)
              request.performSuccess(currentPlayer)
            } else {
              request.performFailure(kGenericError)
            }
          })
          .onFailure({ (error) -> () in
            request.performFailure(error)
          })
        } else {
          // Replace error with meaningful NSError
          request.performFailure(kGenericError)
        }
      } else {
        // Replace error with meaningful NSError
        request.performFailure(kGenericError)
      }
    }
    
    task.resume()
    return request
  }
  
  func refreshAccessTokenForSession(session: Session) -> RefreshTokenRequest {
    let refreshToken = session.accessDetails.refreshToken
    let parameters = [
      "grant_type": "refresh_token",
      "client_id": client.id,
      "client_secret": client.secret,
      "refresh_token": refreshToken,
    ]
    let url = NSURL(string: "\(kPlayerMeApiBaseHost)/oauth/access_token")!
    var err: NSError?
    let request = RefreshTokenRequest(URL: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPMethod = "POST"
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.allZeros, error: &err)
    
    if err != nil {
      // implement
    }
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
      
      if error != nil {
        request.performFailure(error)
      }
      
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let tokenTypeString = decodedJson["token_type"] as? String,
          tokenType = TokenType(rawValue: tokenTypeString),
          accessToken = decodedJson["access_token"] as? String,
          expiresInterval = decodedJson["expires"] as? Double,
          expiresIn = decodedJson["expires_in"] as? Double {
            let expires = NSDate(timeIntervalSince1970: expiresInterval)
            let accessDetails = AccessDetails(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType, expires: expires, expiresIn: expiresIn)
            self.sessionService.updateSession(accessDetails)
            request.performSuccess()
        }
      }
    }
    
    task.resume()
    return request
  }
}
