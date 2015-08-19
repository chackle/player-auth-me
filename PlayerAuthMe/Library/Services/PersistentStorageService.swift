//
//  PersistentStorageService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 17/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PersistentStorageService {
  
  private let userDefaults: NSUserDefaults
  
  init() {
    self.userDefaults = NSUserDefaults()
  }
  
  func storeCurrentSession(session: Session) {
    self.userDefaults.setObject(session.toDictionary(), forKey: kStoredSessionKey)
    self.userDefaults.synchronize()
    println("Session stored: \(session.toDictionary())")
  }
  
  func loadCurrentSession() -> Session? {
    let dictionary = self.userDefaults.objectForKey(kStoredSessionKey) as? [String:AnyObject]
    println("Session loaded: \(dictionary)")
    if let sessionDictionary = dictionary {
      let currentPlayer = sessionDictionary["player"] as? [String:AnyObject]
      let accessDetails = sessionDictionary["accessDetails"] as? [String:AnyObject]
      if let player = currentPlayer,
        id = player["id"] as? Int,
        username = player["username"] as? String,
        shortDescription = player["shortDescription"] as? String,
        longDescription = player["longDescription"] as? String,
        coverUrl = player["coverUrl"] as? String,
        avatarUrl = player["avatarUrl"] as? String,
        isVerified = player["isVerified"] as? Bool,
        isCurrentUser = player["isCurrentUser"] as? Bool,
        isFollowing = player["isFollowing"] as? Bool,
        isFollowed = player["isFollowing"] as? Bool,
        isFriend = player["isFriend"] as? Bool,
        followersCount = player["followersCount"] as? Int,
        followingCount = player["followingCount"] as? Int,
        details = accessDetails,
        accessToken = details["accessToken"] as? String,
        refreshToken = details["refreshToken"] as? String,
        tokenTypeString = details["tokenType"] as? String,
        expires = details["expires"] as? NSDate,
        expiresIn = details["expiresIn"] as? NSTimeInterval {
        let accessDetails = AccessDetails(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenTypeString, expires: expires, expiresIn: expiresIn)
        let player = Player(id: id, username: username, shortDescription: shortDescription, longDescription: longDescription, coverUrl: coverUrl, avatarUrl: avatarUrl, isVerified: isVerified, isCurrentUser: isCurrentUser, isFollowing: isFollowing, isFollowed: isFollowed, isFriend: isFriend, followersCount: followersCount, followingCount: followingCount)
        let session = Session(player: player, accessDetails: accessDetails)
        return session
      }
    }
    return nil
  }
}
