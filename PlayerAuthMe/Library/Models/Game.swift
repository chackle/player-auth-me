//
//  Game.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 26/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

struct Game {
  
  let id: Int
  let title: String
  let boxArtUrl: String
  let isLiked: Bool
  let isFavourited: Bool
  let likesCount: Int
  let favouritesCount: Int
  
  init(id: Int, title: String, boxArtUrl: String, isLiked: Bool, isFavourited: Bool, likesCount: Int, favouritesCount: Int) {
    self.id = id
    self.title = title
    self.boxArtUrl = boxArtUrl
    self.isLiked = isLiked
    self.isFavourited = isFavourited
    self.likesCount = likesCount
    self.favouritesCount = favouritesCount
  }
}
