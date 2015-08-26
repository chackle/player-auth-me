//
//  GameWebService.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 26/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class GameWebService: WebService {
  
  private func requestGame(urlString: String, id: Int) -> GameDetailsRequest {
    let url = "\(urlString)/\(id)"
    let request = GameDetailsRequest(URL: NSURL(string: url)!)
    request.prepare(RequestType.GET)
    request.startWithCompletionHandler { (data, response, error) -> Void in
      if error != nil {
        request.performFailure(error)
      }
      var jsonError: NSError?
      if let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String:AnyObject] {
        if let results = decodedJson["results"] as? [String:AnyObject] {
          if let id = results["id"] as? Int,
            title = results["title"] as? String,
            boxArt = results["box"] as? [String:String],
            originalBoxArt = boxArt["original"],
            likesCount = results["likes_count"] as? Int,
            favouritesCount = results["favourites_count"] as? Int {
              let game = Game(id: id, title: title, boxArtUrl: originalBoxArt, likesCount: likesCount, favouritesCount: favouritesCount)
              game.releaseDateString = results["released_at"] as? String
              game.steamId = results["steam_id"] as? Int
              game.xbox360Id = results["xbox360_id"] as? Int
              game.xboxOneId = results["xboxone_id"] as? Int
              game.alias = results["alias"] as? String
              game.shortDescription = results["short_description"] as? String
              game.websiteUrl = results["website"] as? String
              game.facebookUrl = results["facebook"] as? String
              game.twitterUrl = results["twitter"] as? String
              game.googlePlusUrl = results["gplus"] as? String
              game.steamUrl = results["steam"] as? String
              game.twitchUrl = results["twitch"] as? String
              game.youtubeUrl = results["youtube"] as? String
              game.buyUrl = results["buy_link"] as? String
              if let platformResults = results["platforms"] as? [[String:AnyObject]] {
                var platforms = [Platform]()
                for result in platformResults {
                  if let id = result["id"] as? Int,
                    name = result["name"] as? String {
                      let platform = Platform(id: id, name: name)
                      platforms.append(platform)
                  }
                }
                game.platforms = platforms
              }
              if let developerResults = results["developers"] as? [[String:AnyObject]] {
                var developers = [Developer]()
                for result in developerResults {
                  if let id = result["id"] as? Int,
                    name = result["name"] as? String {
                      let developer = Developer(id: id, name: name)
                      developers.append(developer)
                  }
                }
                game.developers = developers
              }
              if let publisherResults = results["publishers"] as? [[String:AnyObject]] {
                var publishers = [Publisher]()
                for result in publisherResults {
                  if let id = result["id"] as? Int,
                    name = result["name"] as? String {
                      let publisher = Publisher(id: id, name: name)
                      publishers.append(publisher)
                  }
                }
                game.publishers = publishers
              }
            println("Game data: \(game)")
          }
        }
      }
    }
    return request
  }
  
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
                let game = Game(id: id, title: title, boxArtUrl: originalBoxArt, likesCount: likesCount, favouritesCount: favouritesCount, isLiked: isLiked, isFavourited: isFavourited)
                game.longDescription = result["description"] as? String
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
  
  func requestGameWithId(id: Int) -> GameDetailsRequest {
    let url = "\(kPlayerMeApiBaseHost)/v1/games"
    return requestGame(url, id: id)
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
