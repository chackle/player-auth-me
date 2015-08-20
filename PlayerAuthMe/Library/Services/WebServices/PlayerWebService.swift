//
//  PlayerWebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerWebService: WebService {
  
  func requestPlayer(userId: Int? = nil) -> PlayerDetailsRequest {
    var urlString = "\(kPlayerMeApiBaseHost)/v1/users"
    if let id = userId {
      urlString = "\(urlString)/\(id)"
    } else {
      urlString = "\(urlString)/default"
    }
    let url = NSURL(string: urlString)!
    var err: NSError?
    let request = PlayerDetailsRequest(URL: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if err != nil {
      // implement
    }
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
      
      if error != nil {
        // Replace error with meaningful NSError
        request.performFailure(kGenericError)
      }
      
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject], results = decodedJson["results"] as? [String:AnyObject] {
        if let id = results["id"] as? Int,
          username = results["username"] as? String,
          shortDescription = results["short_description"] as? String,
          longDescription = results["description"] as? String,
          followersCount = results["followers_count"] as? Int,
          followingCount = results["following_count"] as? Int,
          isCurrentUser = results["is_current_user"] as? Bool,
          isVerified = results["is_verified"] as? Bool,
          isFollowing = results["is_following"] as? Bool,
          isFollowed = results["is_followed"] as? Bool,
          isFriend = results["is_friend"] as? Bool,
          coverUrls = results["cover"] as? [String:String],
          avatarUrls = results["avatar"] as? [String:String],
          coverUrl = coverUrls["original"],
          avatarUrl = avatarUrls["original"] {
            let player = Player(id: id, username: username, shortDescription: shortDescription, longDescription: longDescription, coverUrl: coverUrl, avatarUrl: avatarUrl, isVerified: isVerified, isCurrentUser: isCurrentUser, isFollowing: isFollowing, isFollowed: isFollowed, isFriend: isFriend, followersCount: followersCount, followingCount: followingCount)
            request.performSuccess([player])
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
  
  func requestPlayers(urlString: String, withParameters parameters: [NSURLQueryItem]? = nil, usingActiveSession activeSession: Session? = nil) -> PlayerDetailsRequest {
    let urlComponents = NSURLComponents(string: urlString)!
    urlComponents.queryItems = parameters
    let request = PlayerDetailsRequest(URL: urlComponents.URL!)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if let session = activeSession {
      request.addValue(session.accessDetails.accessToken, forHTTPHeaderField: "Authorization")
    }
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
      
      if error != nil {
        request.performFailure(error)
      }
      
      var jsonError: NSError?
      
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
      if let results = decodedJson["results"] as? [[String:AnyObject]] {
        var players = [Player]()
        for result in results {
          if let id = result["id"] as? Int,
            username = result["username"] as? String,
            shortDescription = result["short_description"] as? String,
            longDescription = result["description"] as? String,
            followersCount = result["followers_count"] as? Int,
            followingCount = result["following_count"] as? Int,
            isVerified = result["is_verified"] as? Bool,
            isFollowed = result["is_followed"] as? Bool,
            avatarUrls = result["avatar"] as? [String:String],
            avatarUrl = avatarUrls["original"] {
              let player = Player(id: id, username: username, shortDescription: shortDescription, longDescription: longDescription, coverUrl: "", avatarUrl: avatarUrl, isVerified: isVerified, isCurrentUser: false, isFollowing: false, isFollowed: isFollowed, isFriend: false, followersCount: followersCount, followingCount: followingCount)
              players.append(player)
          } else {
            // Replace error with meaningful NSError
            request.performFailure(kGenericError)
          }
        }
        request.performSuccess(players)
      }} else {
        // Replace error with meaningful NSError
        request.performFailure(kGenericError)
      }
    }
    
    task.resume()
    return request
  }
  
  func requestCurrentPlayer() -> PlayerDetailsRequest {
    return requestPlayer()
  }
  
  func requestPlayerWithId(id: Int) -> PlayerDetailsRequest {
    return requestPlayer(userId: id)
  }
  
  func requestPlayerSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> PlayerDetailsRequest {
    var parameters = [
      NSURLQueryItem(name: "_query", value: searchQuery),
      NSURLQueryItem(name: "_limit", value: "\(limit)")
    ]
    if let p = page {
      NSURLQueryItem(name: "_page", value: "\(p)")
    } else if let f = from {
      NSURLQueryItem(name: "_from", value: "\(f)")
    }
    let url = "\(kPlayerMeApiBaseHost)/v1/users"
    return requestPlayers(url, withParameters: parameters)
  }
  
  func requestOnlinePlayersForSession(session: Session) -> PlayerDetailsRequest {
    // MARK: TODO still needs implemented
    let url = "\(kPlayerMeApiBaseHost)/v1/users/online"
    return requestPlayers(url)
  }
}
