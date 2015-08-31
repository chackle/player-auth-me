//
//  FeedWebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 27/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class FeedWebService: WebService {
  
  func requestFeedUsingSession(session: Session, withLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil, fromSources sources: [FeedSource]) -> FeedRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/feed"
    var parameters = [
      "_limit": limit,
      "general": true
    ] as [String:AnyObject]
    if let page = page {
      parameters["_page"] = page
    } else if let from = from {
      parameters["_from"] = from
    }
    let request = FeedRequest(URL: NSURL(string: url)!)
    request.prepare(RequestType.GET, withParameters: parameters, usingSession: session)
    request.startWithCompletionHandler { (data, response, error) -> Void in
      if error != nil {
        request.performFailure(error)
      }
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let results = decodedJson["results"] as? [[String:AnyObject]] {
          var posts = [FeedPost]()
          for result in results {
            if let id = result["id"] as? Int,
              userId = result["user_id"] as? Int,
              type = result["type"] as? String,
              resourceId = result["resource_id"] as? Int,
              source = result["source"] as? String,
              publishedAtString = result["published_at"] as? String,
              createdAtString = result["created_at"] as? String,
              updatedAtString = result["updated_at"] as? String,
              user = result["user"] as? [String:AnyObject],
              isLiked = result["hasLiked"] as? Bool,
              isSubscribed = result["isSubscribed"] as? Bool,
              showEdit = result["showEdit"] as? Bool,
              showDelete = result["showDelete"] as? Bool,
              userIsHidden = result["userIsHidden"] as? Bool,
              userIsBlocked = result["userIsBlocked"] as? Bool,
              userIsFollowed = result["userIsFollowed"] as? Bool,
              isOwnActivity = result["isOwnActivity"] as? Bool,
              isPinned = result["hasPinned"] as? Bool,
              pinsCount = result["pinsCount"] as? Int,
              isShared = result["hasShared"] as? Bool,
              shareCount = result["shareCount"] as? Int,
              postData = result["data"] as? [String:AnyObject],
              commentsCount = result["commentsCount"] as? Int,
              commentsData = result["comments"] as? [[String:AnyObject]],
              likesCount = result["likesCount"] as? Int {
                var comments = [Comment]()
                for comment in commentsData {
                  if let id = comment["id"] as? Int,
                  userId = comment["user_id"] as? Int,
                  activityUserId = comment["activity_user_id"] as? Int,
                  activityId = comment["activity_id"] as? Int,
                  data = comment["data"] as? [String:AnyObject],
                  text = data["post"] as? String,
                  raw = data["post_raw"] as? String,
                  createdAtString = comment["created_at"] as? String,
                  updatedAtString = comment["updated_at"] as? String,
                  userIsBlocked = comment["userIsBlocked"] as? Bool,
                  isLiked = comment["hasLiked"] as? Bool,
                  url = comment["url"] as? String,
                  showDelete = comment["showDelete"] as? Bool,
                  showEdit = comment["showEdit"] as? Bool,
                  isOwnComment = comment["isOwnComment"] as? Bool,
                  likesCount = comment["likesCount"] as? Int,
                  player = comment["user"] as? [String:AnyObject] {
                    if let authorId = player["id"] as? Int,
                    authorUsername = player["username"] as? String,
                    authorAccountTypeString = player["account_type"] as? String,
                    authorAccountType = AccountType(rawValue: authorAccountTypeString),
                    authorAvatar = player["avatar"] as? String,
                    authorFollowersCount = player["followers_count"] as? Int,
                    authorIsFeatured = player["is_featured"] as? Bool,
                    authorIsVerified = player["is_verified"] as? Bool,
                    authorIsPrivate = player["is_private"] as? Bool {
                      let author = Player(id: authorId, username: authorUsername, shortDescription: "", longDescription: "", coverUrl: "", avatarUrl: authorAvatar, isVerified: authorIsVerified, isCurrentUser: false, isFollowing: false, isFollowed: false, isFriend: false, followersCount: authorFollowersCount, followingCount: 0)
                      let comment = Comment(id: id, userId: userId, activityUserId: activityUserId, activityId: activityId, createdAtString: createdAtString, updatedAtString: updatedAtString, userIsBlocked: userIsBlocked, isLiked: isLiked, url: url, showDelete: showDelete, showEdit: showEdit, isOwnComment: isOwnComment, likesCount: likesCount, text: text, raw: raw, user: author)
                      comments.append(comment)
                    }
                  }
                }
                if let playerId = user["id"] as? Int,
                username = user["username"] as? String,
                accountTypeString = user["account_type"] as? String,
                accountType = AccountType(rawValue: accountTypeString),
                avatar = user["avatar"] as? String,
                followersCount = user["followers_count"] as? Int,
                isFeatured = user["is_featured"] as? Bool,
                isVerified = user["is_verified"] as? Bool,
                isPrivate = user["is_private"] as? Bool {
                  if let postText = postData["post"] as? String,
                  postRaw = postData["post_raw"] as? String,
                  metas = postData["metas"] as? [[String:AnyObject]] {
                    var metaData = [PostMeta]()
                    for meta in metas {
                      if let url = meta["url"] as? String,
                      contentString = meta["content"] as? String,
                      provider = meta["provider"] as? String,
                      content = PostMetaContent(rawValue: contentString),
                      title = meta["title"] as? String,
                      thumbnail = meta["thumbnail"] as? String {
                        var postMetaData = PostMeta(url: url, title: title, provider: provider, thumbnail: thumbnail, content: content)
                        postMetaData.description = meta["description"] as? String
                        metaData.append(postMetaData)
                      }
                    }
                    let data = PostData(text: postText, raw: postRaw, metaData: metaData)
                    if let game = postData["game"] as? [String:AnyObject],
                    id = game["id"] as? Int,
                    title = game["title"] as? String,
                    shortDescription = game["short_description"] as? String,
                    boxData = game["cover"] as? [String:String],
                    originalBox = boxData["original"],
                    checkInType = game["check_in_type"] as? String,
                    likesCount = game["likes_count"] as? Int,
                    isLiked = game["has_liked"] as? Bool {
                      // add game to post data here
                      var game = Game(id: id, title: title, boxArtUrl: originalBox, likesCount: likesCount, favouritesCount: 0)
                      data.game = game
                    }
                    let player = Player(id: playerId, username: username, shortDescription: "", longDescription: "", coverUrl: "", avatarUrl: avatar, isVerified: isVerified, isCurrentUser: isOwnActivity, isFollowing: false, isFollowed: userIsFollowed, isFriend: false, followersCount: followersCount, followingCount: 0)
                    
                    var post = FeedPost(id: id, userId: userId, type: type, resourceId: resourceId, source: source, commentsCount: commentsCount, likesCount: likesCount, pinsCount: pinsCount, shareCount: shareCount, comments: comments, isLiked: isLiked, isSubscribed: isSubscribed, showEdit: showEdit, showDelete: showDelete, userIsHidden: userIsHidden, userIsFollowed: userIsFollowed, isOwnActivity: isOwnActivity, isPinned: isPinned, isShared: isShared, createdAtString: createdAtString, publishedAtString: publishedAtString, updatedAtString: updatedAtString, user: player, data: data)
                    posts.append(post)
                }
              }
            }
          }
          request.performSuccess(posts)
        }
      }
    }
    return request
  }
  
  func postToFeedUsingSession(session: Session, withText text: String, andImages images: [UIImage]? = nil, andCheckInGameId gameId: Int? = nil) -> FeedPostRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/feed"
    var parameters = [
      "post": text
      ] as [String:AnyObject]
    if let images = images
      where images.count > 0 {
        parameters["files"] = convertUIImagesToBase64(images)
    }
    if let gameId = gameId {
      parameters["game_id"] = gameId
    }
    let request = FeedPostRequest(URL: NSURL(string: url)!)
    request.prepare(RequestType.POST, withParameters: parameters)
    request.startWithCompletionHandler { (data, response, error) -> Void in
      if error != nil {
        request.performFailure(error)
      }
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        // Pass back relevant information (will flesh this out when I do the GET feed)
        println("data \(decodedJson)")
        request.performSuccess()
      } else {
        // Replace error with meaningful NSError
        request.performFailure(kGenericError)
      }
    }
    return request
  }
  
  private func convertUIImagesToBase64(images: [UIImage]) -> [String] {
    var base64Strings = [String]()
    for image in images {
      let imageData = UIImagePNGRepresentation(image)
      base64Strings.append(imageData.base64EncodedStringWithOptions(.allZeros))
    }
    return base64Strings
  }
}
