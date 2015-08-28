//
//  PostMetaContent.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

enum PostMetaContent: String {
  
  case Link = "link"
  case Photo = "photo"
  case Video = "video"
  
  static let allValues = [Link, Photo, Video]
  static let allRawValues = [Link.rawValue, Photo.rawValue, Video.rawValue]
}
