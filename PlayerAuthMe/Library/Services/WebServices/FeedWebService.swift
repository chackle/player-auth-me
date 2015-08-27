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
