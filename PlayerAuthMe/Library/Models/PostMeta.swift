//
//  PostMeta.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PostMeta {
  
  var url: String
  var title: String
  var provider: String
  var thumbnail: String
  var content: PostMetaContent
  
  var description: String?
  
  init(url: String, title: String, provider: String, thumbnail: String, content: PostMetaContent) {
    self.url = url
    self.title = title
    self.provider = provider
    self.content = content
    self.thumbnail = thumbnail
  }
  
  convenience init(url: String, title: String, description: String?, provider: String, thumbnail: String, content: PostMetaContent) {
    self.init(url: url, title: title, provider: provider, thumbnail: thumbnail, content: content)
    self.description = description
  }
}
