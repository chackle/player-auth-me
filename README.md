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
