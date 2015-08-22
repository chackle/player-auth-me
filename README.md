# PlayerAuthMe
___
A simple framework for implementing player.me OAuth API

# Setting your clientId and clientSecret
These are requested from player.me. They should be statically set within your app and not reused across apps.
```swift
var playerAuthMe = PlayerAuthMe.sharedInstance
    playerAuthMe.clientId("your_client_id")
    playerAuthMe.clientSecret("your_client_secret")
```

# Authentication with username and password
The idea here is that we authenticate once with the player.me servers. Once a session is active the library handles all authenticated requests automatically. If `playerAuthMe.endSession()` is called, the session will no longer be active and any requests requiring authentication will fail.
```swift
var playerAuthMe = PlayerAuthMe.sharedInstance
    playerAuthMe.authenticateUser("username", withPassword: "password")
    .onSuccess { (result) -> () in
      println("Success! Result: \(result)")
    }
    .onFailure { (error) -> () in
      println("Failure :( \(error)")
    }
```

# Refreshing current user access
In order to refresh access we need to have obtained access in the first place. For this reason the session must be passed into `refreshAccessTokenForSession`. Dependency injection is used here in case you need to check the session validity before the request is attempted.
```swift
if let session = playerAuthMe.activeSession() {
  playerAuthMe.refreshAccessTokenForSession(session)
  .onSuccess({ () -> () in
    println("Refresh success!")
  })
  .onFailure({ (error) -> () in
    println("Refresh error! \(error)")
  })
}
```

# Getting a Specific User’s Info
A simple request which does not require authentication.
```swift
playerAuthMe.requestPlayerWithId(1)
.onSuccess { (players) -> () in
  println("Have queried 1.. have gotten \(players[0].toDictionary())")
}
.onFailure { (error) -> () in
  println("Request Player Error! \(error)")
}
```

# Searching for a User based on a string
The string passed in will be queried against player usernames.
```swift
playerAuthMe.requestPlayerSearch("cha", andLimit: 20, andPage: 1)
.onSuccess { (players) -> () in
  println("Have queried 'cha'.. have gotten \(players)")
}
.onFailure { (error) -> () in
  println("Search Players Error! \(error)")
}
```

# ..or a query!
A query allows a filter to be passed in order to order the data. Sadly it seems this is only possible when not searching with a string also.
```swift
playerAuthMe.requestPlayerSearch(FilterType.Popular.rawValue, andLimit: 20, andPage: 1)
.onSuccess { (players) -> () in
  println("Have queried ‘_filter:popular’.. have gotten \(players)")
}
.onFailure { (error) -> () in
  println("Search Players Error! \(error)")
}
```

# Getting all current user’s followed players online
This is a chained request with three stages in order to return the data requested.

1. Requests the user ids for the logged in user’s online followed list
2. Creates a call for each user, piggy backing off `requestPlayerWithId`
3. Returns full details of all requested players

```swift
playerAuthMe.requestOnlineFollowedPlayersForSession(session)
.onSuccess({ (players) -> () in
  println("Request online players success \(players)")
})
.onFailure({ (error) -> () in
  println("Request online players error \(error)")
})
```