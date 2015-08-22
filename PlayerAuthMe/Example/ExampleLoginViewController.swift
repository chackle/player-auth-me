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
  
  @IBOutlet var usernameField: UITextField!
  @IBOutlet var passwordField: UITextField!
  private let playerAuthMe = PlayerAuthMe.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    playerAuthMe.clientId("your_client_id")
    playerAuthMe.clientSecret("your_client_secret")
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    // MARK: Requests which require valid authentication
    // Check to see if the current session is valid
    if let session = playerAuthMe.activeSession() {
      println("performing segue")
      performSegueWithIdentifier("presentHomeViewController", sender: nil)
    }
  }
  
  @IBAction func authenticateAndTest() {
    let username = usernameField.text
    let password = passwordField.text!
    
    // MARK: Requests which do not require valid authentication
    // Authenticating
    playerAuthMe.authenticateUser(username, withPassword: password)
      .onSuccess { (result) -> () in
        println("Success! Result: \(result.toDictionary())")
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.performSegueWithIdentifier("presentHomeViewControllerAnimated", sender: nil)
        })
      }
      .onFailure { (error) -> () in
        println("Failure :( \(error)")
    }
    
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
