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
      
      let details = PlayerDetailsWrapper()
                    .changeUsername("chackle")
                    .changeLongDescription("Follow me, I'm awesome!")
                    .changeEmail("new_email@email.com")
                    .changeAccountType(AccountType.User)
      playerAuthMe.requestToEditPlayerForSession(session, withChangedDetails:details)
      .onSuccess({ () -> () in
        println("Request Player Edit success!")
      })
      .onFailure({ (error) -> () in
        println("Request Player Edit error \(error)")
      })
    }
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
