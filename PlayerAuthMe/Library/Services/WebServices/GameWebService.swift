//
//  GameWebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 26/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class GameWebService: WebService {
  
  private func requestGames(urlString: String, withParameters parameters: [String:AnyObject]? = nil) -> GameDetailsRequest {
    let request = GameDetailsRequest(URL: NSURL(string: urlString)!)
    request.prepare(RequestType.GET, withParameters: parameters)
    request.startWithCompletionHandler { (data, response, error) -> Void in
      if error != nil {
        request.performFailure(error)
      }
      
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let results = decodedJson["results"] as? [[String:AnyObject]] {
          var games = [Game]()
          for result in results {
            if let id = result["id"] as? Int,
              title = result["title"] as? String,
              boxArt = result["box"] as? [String:String],
              originalBoxArt = boxArt["original"],
              isLiked = result["has_liked"] as? Bool,
              isFavourited = result["has_favourited"] as? Bool,
              likesCount = result["likes_count"] as? Int,
              favouritesCount = result["favourites_count"] as? Int {
                let game = Game(id: id, title: title, boxArtUrl: originalBoxArt, isLiked: isLiked, isFavourited: isFavourited, likesCount: likesCount, favouritesCount: favouritesCount)
                games.append(game)
            } else {
              // Replace error with meaningful NSError
              request.performFailure(kGenericError)
            }
          }
          request.performSuccess(games)
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
  
  func requestGameSearch(searchQuery: String, andLimit limit: Int, andPage page: Int? = nil, orFrom from: Int? = nil) -> GameDetailsRequest {
    var parameters = [
      "_query": searchQuery,
      "_limit": limit
      ] as [String:AnyObject]
    if let p = page {
      parameters["_page"] = p
    } else if let f = from {
      parameters["_from"] = f
    }
    let url = "\(kPlayerMeApiBaseHost)/v1/games"
    return requestGames(url, withParameters: parameters)
  }
}
