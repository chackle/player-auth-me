//
//  Constants.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 14/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

// API
let kPlayerMeApiBaseHost = "https://player.me/api"

// Storage
let kStoredSessionKey = "com.chackle.PlayerAuthMe.storedSession"

// Temporary
let kGenericError = NSError(domain: "com.chackle.PlayerAuthMe", code: -1337, userInfo: ["message":"This is a generic, temporary error. Something went wrong, but this won't tell you why."])