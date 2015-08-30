//
//  Comment.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class Comment {
  
  var id: Int
  var userId: Int
  var activityUserId: Int
  var activityId: Int
  var createdAtString: String
  var updatedAtString: String
  var editedAtString: String?
  var userIsBlocked: Bool
  var isLiked: Bool
  var url: String
  var showDelete: Bool
  var showEdit: Bool
  var isOwnComment: Bool
  var likesCount: Int
  var text: String
  var raw: String
  var user: Player
  
  init(id: Int, userId: Int, activityUserId: Int, activityId: Int, createdAtString: String, updatedAtString: String, userIsBlocked: Bool, isLiked: Bool, url: String, showDelete: Bool, showEdit: Bool, isOwnComment: Bool, likesCount: Int, text: String, raw: String, user: Player) {
    self.id = id
    self.userId = userId
    self.activityUserId = activityUserId
    self.activityId = activityId
    self.createdAtString = createdAtString
    self.updatedAtString = updatedAtString
    self.userIsBlocked = userIsBlocked
    self.isLiked = isLiked
    self.url = url
    self.showDelete = showDelete
    self.showEdit = showEdit
    self.isOwnComment = isOwnComment
    self.likesCount = likesCount
    self.text = text
    self.raw = raw
    self.user = user
  }
}
