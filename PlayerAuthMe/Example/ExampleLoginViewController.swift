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
    playerAuthMe.authenticateUser("email_or_username", withPassword: "password")
    .onSuccess { (result) -> () in
      println("Success! Result: \(result)")
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
  }
}
