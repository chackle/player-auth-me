//
//  FeedPost.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class FeedPost {
  
  var id: Int
  var userId: Int
  var type: String
  var resourceId: Int
  var source: FeedSource?
  var commentsCount: Int
  var likesCount: Int
  var pinsCount: Int
  var shareCount: Int
  var comments: [Comment]
  var isLiked: Bool
  var isSubscribed: Bool
  var showEdit: Bool
  var showDelete: Bool
  var userIsHidden: Bool
  var userIsFollowed: Bool
  var isOwnActivity: Bool
  var isPinned: Bool
  var isShared: Bool
  var createdAtString: String
  var publishedAtString: String
  var updatedAtString: String
  var editedAtString: String?
  
  var data: PostData
  var user: Player
  
  init(id: Int, userId: Int, type: String, resourceId: Int, source: String, commentsCount: Int, likesCount: Int, pinsCount: Int, shareCount: Int, comments: [Comment], isLiked: Bool, isSubscribed: Bool, showEdit: Bool, showDelete: Bool, userIsHidden: Bool, userIsFollowed: Bool, isOwnActivity: Bool, isPinned: Bool, isShared: Bool, createdAtString: String, publishedAtString: String, updatedAtString: String, user: Player, data: PostData) {
    self.id = id
    self.userId = userId
    self.type = type
    self.resourceId = resourceId
    self.source = FeedSource(rawValue: source)
    self.commentsCount = commentsCount
    self.likesCount = likesCount
    self.pinsCount = pinsCount
    self.shareCount = shareCount
    self.comments = comments
    self.isLiked = isLiked
    self.isSubscribed = isSubscribed
    self.showEdit = showEdit
    self.showDelete = showDelete
    self.userIsHidden = userIsHidden
    self.userIsFollowed = userIsFollowed
    self.isOwnActivity = isOwnActivity
    self.isPinned = isPinned
    self.isShared = isShared
    self.createdAtString = createdAtString
    self.publishedAtString = publishedAtString
    self.updatedAtString = updatedAtString
    self.user = user
    self.data = data
  }
  
  convenience init(id: Int, userId: Int, type: String, resourceId: Int, source: String, commentsCount: Int, likesCount: Int, pinsCount: Int, shareCount: Int, comments: [Comment], isLiked: Bool, isSubscribed: Bool, showEdit: Bool, showDelete: Bool, userIsHidden: Bool, userIsFollowed: Bool, isOwnActivity:Bool, isPinned: Bool, isShared: Bool, createdAtString: String, publishedAtString: String, updatedAtString: String, editedAtString: String?, user: Player, data: PostData) {
    self.init(id: id, userId: userId, type: type, resourceId: resourceId, source: source, commentsCount: commentsCount, likesCount: likesCount, pinsCount: pinsCount, shareCount: shareCount, comments: comments, isLiked: isLiked, isSubscribed: isSubscribed, showEdit: showEdit, showDelete: showDelete, userIsHidden: userIsHidden, userIsFollowed: userIsFollowed, isOwnActivity: isOwnActivity, isPinned: isPinned, isShared: isShared, createdAtString: createdAtString, publishedAtString: publishedAtString, updatedAtString: updatedAtString, user: user, data: data)
    self.editedAtString = editedAtString
  }
}
