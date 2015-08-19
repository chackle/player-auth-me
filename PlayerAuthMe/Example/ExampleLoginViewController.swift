//
//  ExampleLoginViewController.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 14/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class ExampleLoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var playerAuthMe = PlayerAuthMe.sharedInstance
    playerAuthMe.clientId("your_client_id")
    playerAuthMe.clientSecret("your_client_secret")

    // Authenticating
    playerAuthMe.authenticateUser("username", withPassword: "password")
    .onSuccess { (result) -> () in
      println("Success! Result: \(result.toDictionary())")
    }
    .onFailure { (error) -> () in
      println("Failure :( \(error)")
    }
    
    // Refreshing Access Token
    playerAuthMe.refreshAccessTokenForCurrentSession()
    .onSuccess({ () -> () in
      println("Refresh success!")
    })
    .onFailure({ (error) -> () in
      println("Refresh error! \(error)")
    })
    
    // Getting a Specific User's Info
    playerAuthMe.requestPlayerWithId(1)
    .onSuccess { (players) -> () in
      println("Have queried 1.. have gotten \(players[0].toDictionary())")
    }
    .onFailure { (error) -> () in
      println("Request Player Error! \(error)")
    }

    // Searching a list of User's by string
    playerAuthMe.requestPlayerSearch("cha", andLimit: 20, andPage: 1)
    .onSuccess { (players) -> () in
      println("Have queried 'cha'.. have gotten \(players)")
    }
    .onFailure { (error) -> () in
      println("Search Players Error! \(error)")
    }
  }
}
