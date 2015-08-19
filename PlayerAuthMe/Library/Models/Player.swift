//
//  Player.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 17/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class Player {
  
  let id: Int
  let username: String
  let shortDescription: String
  let longDescription: String
  let coverUrl: String
  let avatarUrl: String
  let isVerified: Bool
  let isCurrentUser: Bool
  let isFollowing: Bool
  let isFollowed: Bool
  let isFriend: Bool
  let followersCount: Int
  let followingCount: Int
  
  init(id: Int, username: String, shortDescription: String, longDescription: String, coverUrl: String, avatarUrl: String, isVerified: Bool, isCurrentUser: Bool, isFollowing: Bool, isFollowed: Bool, isFriend: Bool, followersCount: Int, followingCount: Int) {
    self.id = id
    self.username = username
    self.shortDescription = shortDescription
    self.longDescription = longDescription
    self.coverUrl = coverUrl
    self.avatarUrl = avatarUrl
    self.isVerified = isVerified
    self.isCurrentUser = isCurrentUser
    self.isFollowing = isFollowing
    self.isFollowed = isFollowed
    self.isFriend = isFriend
    self.followersCount = followersCount
    self.followingCount = followingCount
  }
  
  func toDictionary() -> [String:AnyObject] {
    return [
      "id": id,
      "username": username,
      "shortDescription": shortDescription,
      "longDescription": longDescription,
      "coverUrl": coverUrl,
      "avatarUrl": avatarUrl,
      "isVerified": isVerified,
      "isCurrentUser": isCurrentUser,
      "isFollowing": isFollowing,
      "isFollowed": isFollowed,
      "isFriend": isFriend,
      "followersCount": followersCount,
      "followingCount": followingCount
    ]
  }
}
