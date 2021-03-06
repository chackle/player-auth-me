//
//  PlayerWebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 19/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PlayerWebService: WebService {
  
  // MARK: Player Details Requests
  private func requestPlayer(urlString: String, userId: Int? = nil) -> PlayerDetailsRequest {
    var url = urlString
    if let id = userId {
      url = "\(urlString)/\(id)"
    } else {
      url = "\(urlString)/default"
    }
    let request = PlayerDetailsRequest(URL: NSURL(string: url)!)
    request.prepare(RequestType.GET)
    request.startWithCompletionHandler { (data, response, error) -> Void in
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
    return request
  }
  
  func requestPlayers(urlString: String, withParameters parameters: [String:AnyObject]? = nil, usingActiveSession activeSession: Session? = nil) -> PlayerDetailsRequest {
    let request = PlayerDetailsRequest(URL: NSURL(string: urlString)!)
    request.prepare(RequestType.GET, withParameters: parameters, usingSession: activeSession)
    request.startWithCompletionHandler { (data, response, error) -> Void in
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
        } else {
          // Replace error with meaningful NSError
          request.performFailure(kGenericError)
        }
      } else {
        // Replace error with meaningful NSError
        request.performFailure(kGenericError)
      }
    }
    return request
  }
  
  func requestCurrentPlayer() -> PlayerDetailsRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/users"
    return requestPlayer(url)
  }
  
  func requestPlayerWithId(id: Int) -> PlayerDetailsRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/users"
    return requestPlayer(url, userId: id)
  }
  
  func requestPlayerSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> PlayerDetailsRequest {
    var parameters = [
      "_query": searchQuery,
      "_limit": limit
    ] as [String:AnyObject]
    if let p = page {
      parameters["_page"] = p
    } else if let f = from {
      parameters["_from"] = f
    }
    let url = "\(kPlayerMeApiBaseHost)/v1/users"
    return requestPlayers(url, withParameters: parameters)
  }
  
  func requestOnlineFollowedPlayersForSession(session: Session) -> PlayerDetailsRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/users/online"
    let request = PlayerDetailsRequest(URL: NSURL(string: url)!)
    request.prepare(RequestType.GET, usingSession: session)
    request.startWithCompletionHandler { (data, response, error) -> Void in
      if error != nil {
        request.performFailure(error)
      }
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let results = decodedJson["results"] as? [Int] {
          var followedPlayers = [Player]()
          if results.count == 0 {
            request.performSuccess(followedPlayers)
          } else {
            for result in results {
              self.requestPlayerWithId(result)
              .onSuccess({ (players) -> () in
                followedPlayers.append(players[0])
                if followedPlayers.count == results.count {
                  request.performSuccess(followedPlayers)
                }
              })
              .onFailure({ (error) -> () in
                request.performFailure(error)
              })
            }
          }
        }
      } else {
        request.performFailure(jsonError!)
      }
    }
    return request
  }
  
  
  // MARK: Player Edit Requests
  func editPlayerForSession(session: Session, withSessionService sessionService: SessionService? = nil, withDetails details: PlayerDetailsWrapper) -> PlayerEditRequest {
    return editPlayerForSession(session, withSessionService: sessionService, withParameters: details.toDictionary())
  }
  
  func editPlayerForSession(session: Session, withNewPassword password: String, andConfirmedPassword confirmedPassword: String) -> PlayerEditRequest {
    let parameters = [
      "newpassword": password,
      "confirm": confirmedPassword
    ]
    return editPlayerForSession(session, withParameters: parameters)
  }
  
  func editPlayerForSession(session: Session, withAccountPrivacy privacy: AccountPrivacy) -> PlayerEditRequest {
    let parameters = [
      "is_private": (privacy == AccountPrivacy.Private) ? true : false
    ]
    return editPlayerForSession(session, withParameters: parameters)
  }
  
  func editPlayerForSession(session: Session, withMessagingPolicy policy: MessagingPolicy) -> PlayerEditRequest {
    let parameters = [
      "allow_message_from_everyone": (policy == MessagingPolicy.Everyone) ? true : false
    ]
    return editPlayerForSession(session, withParameters: parameters)
  }
  
  func editPlayerForSession(session: Session, withOnlineVisibility visibility: OnlineVisibility) -> PlayerEditRequest {
    let parameters = [
      "allow_message_from_everyone": (visibility == OnlineVisibility.Everyone) ? true : false
    ]
    return editPlayerForSession(session, withParameters: parameters)
  }
  
  private func editPlayerForSession(session: Session, withSessionService sessionService: SessionService? = nil, withParameters parameters: [String:AnyObject]) -> PlayerEditRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/users/default"
    var request = PlayerEditRequest(URL: NSURL(string: url)!)
    request.prepare(RequestType.PUT, withParameters: parameters, usingSession: session)
    request.startWithCompletionHandler { (data, response, error) -> Void in
      if error != nil {
        request.performFailure(error)
      }
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let success = decodedJson["success"] as? Bool
          where success == true {
            if let modified = decodedJson["modified"] as? [String:AnyObject], sessionService = sessionService {
              // Update any relevant player information
              let playerDetails = PlayerDetailsWrapper()
              if let username = modified["username"] as? String {
                playerDetails.changeUsername(username)
              }
              if let description = modified["description"] as? String {
                playerDetails.changeLongDescription(description)
              }
              sessionService.updateSession(playerDetails)
            }
            request.performSuccess()
        } else {
          request.performFailure(kGenericError)
        }
      } else {
        request.performFailure(kGenericError)
      }
    }
    return request
  }
}
