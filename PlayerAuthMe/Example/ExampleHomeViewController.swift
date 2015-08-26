//
//  ExampleHomeViewController.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 20/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class ExampleHomeViewController: UIViewController {
  
  @IBOutlet var usernameLabel: UILabel!
  @IBOutlet var followersLabel: UILabel!
  @IBOutlet var followingLabel: UILabel!
  @IBOutlet var shortDescriptionLabel: UILabel!
  private let playerAuthMe = PlayerAuthMe.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let session = playerAuthMe.activeSession() {
      println("sessionservice.session = \(session.player.username)")
      // Update Player Information
      updatePlayerInformation(session.player)
      
      // Refreshing Access Token
      playerAuthMe.refreshAccessTokenForSession(session)
      .onSuccess({ () -> () in
        println("Refresh success!")
      })
      .onFailure({ (error) -> () in
        println("Refresh error! \(error)")
        self.logout()
      })
      
      playerAuthMe.requestOnlineFollowedPlayersForSession(session)
      .onSuccess({ (players) -> () in
        println("Request online players success \(players)")
      })
      .onFailure({ (error) -> () in
        println("Request online players error \(error)")
      })
      
      playerAuthMe.requestGameSearch("Starcraft", andLimit: 20, andPage: 1)
      .onSuccess({ (games) -> () in
        for game in games {
          println("Got: \(game.title)")
        }
      })
      .onFailure({ (error) -> () in
        println("Did not get the games")
      })
      
      playerAuthMe.requestGameWithId(1)
      .onSuccess({ (games) -> () in
        println("Successfully got game \(games[0])")
      })
      .onFailure({ (error) -> () in
        println("Did not get game \(error)")
      })
      //testEditing(session)
    }
  }
  
  private func testEditing(session: Session) {
    let details = PlayerDetailsWrapper()
    .changeUsername("username123")
    .changeLongDescription("Follow me, I'm awesome!")
    .changeEmail("your@new_email.com")
    .changeAccountType(AccountType.User)
    
    playerAuthMe.editPlayerForSession(session, withDetails:details)
    .onSuccess({ () -> () in
      println("Request Player Edit success!")
      // Update your UI
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.updatePlayerInformation(session.player)
      })
    })
    .onFailure({ (error) -> () in
      println("Request Player Edit error \(error)")
    })
    
    playerAuthMe.editPlayerForSession(session, withAccountPrivacy: AccountPrivacy.Private)
    .onSuccess({ () -> () in
      println("Request player privacy edit success!")
    })
    .onFailure({ (error) -> () in
      println("Request player Privacy edit error \(error)")
    })
  }
  
  @IBAction private func logoutPressed() {
    self.logout()
  }
  
  private func updatePlayerInformation(player: Player) {
    usernameLabel.text = player.username
    followersLabel.text = "\(player.followersCount) followers"
    followingLabel.text = "\(player.followingCount) following"
    shortDescriptionLabel.text = player.shortDescription
  }
  
  private func logout() {
    self.playerAuthMe.endSession()
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
