//
//  PostData.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 28/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

class PostData {
  
  var text: String
  var raw: String
  var game: Game?
  var metaData: [PostMeta]
  
  init(text: String, raw: String, metaData: [PostMeta]) {
    self.text = text
    self.raw = raw
    self.metaData = metaData
  }
  
  convenience init(text: String, raw: String, metaData: [PostMeta], game: Game?) {
    self.init(text: text, raw: raw, metaData: metaData)
    self.game = game
  }
}
