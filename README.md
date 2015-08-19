# PlayerAuthMe
A simple framework for implementing player.me OAuth API

# Setting your clientId and clientSecret
```swift
var playerAuthMe = PlayerAuthMe.sharedInstance
    playerAuthMe.clientId("your_client_id")
    playerAuthMe.clientSecret("your_client_secret")
```

# Authentication with username and password
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
```swift
playerAuthMe.refreshAccessTokenForCurrentSession()
.onSuccess({ () -> () in
  println("Refresh success!")
})
.onFailure({ (error) -> () in
  println("Refresh error! \(error)")
})
```

# Getting a Specific User’s Info
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
```swift
playerAuthMe.requestPlayerSearch(FilterType.Popular, andLimit: 20, andPage: 1)
.onSuccess { (players) -> () in
  println("Have queried ‘_filter:popular’.. have gotten \(players)")
}
.onFailure { (error) -> () in
  println("Search Players Error! \(error)")
}
```