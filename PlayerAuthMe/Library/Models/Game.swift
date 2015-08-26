//
//  Game.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 26/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class Game {
  
  // Mandatory variables
  var id: Int
  var title: String
  var boxArtUrl: String
  var likesCount: Int
  var favouritesCount: Int
  
  // Optional variables
  var isLiked: Bool?
  var isFavourited: Bool?
  var releaseDateString: String?
  var steamId: Int?
  var xbox360Id: Int?
  var xboxOneId: Int?
  var alias: String?
  var longDescription: String?
  var shortDescription: String?
  var websiteUrl: String?
  var facebookUrl: String?
  var twitterUrl: String?
  var googlePlusUrl: String?
  var steamUrl: String?
  var twitchUrl: String?
  var youtubeUrl: String?
  var buyUrl: String?
  
  var platforms: [Platform]?
  var developers: [Developer]?
  var publishers: [Publisher]?
  
  init(id: Int, title: String, boxArtUrl: String, likesCount: Int, favouritesCount: Int) {
    self.id = id
    self.title = title
    self.boxArtUrl = boxArtUrl
    self.likesCount = likesCount
    self.favouritesCount = favouritesCount
  }
  
  convenience init(id: Int, title: String, boxArtUrl: String, likesCount: Int, favouritesCount: Int, isLiked: Bool, isFavourited: Bool) {
    self.init(id: id, title: title, boxArtUrl: boxArtUrl, likesCount: likesCount, favouritesCount: favouritesCount)
    self.isLiked = isLiked
    self.isFavourited = isFavourited
  }
}
