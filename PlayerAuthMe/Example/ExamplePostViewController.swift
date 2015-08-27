//
//  ExamplePostViewController.swift
//  PlayerAuthMe
//
//  Created by Michael Green on 27/08/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class ExamplePostViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var textField: UITextField!
  @IBOutlet var button: UIButton!
  
  private let playerAuthMe = PlayerAuthMe.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func postToFeed() {
    if let session = playerAuthMe.activeSession() {
      button.userInteractionEnabled = false
      button.alpha = 0.3
      playerAuthMe.postToFeedUsingSession(session, withText: textField.text, andImages: [imageView.image!])
      .onSuccess({ () -> () in
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          // Updates to UI must be on main thread
          self.button.userInteractionEnabled = true
          self.button.alpha = 1.0
        })
        println("Successful post!")
      })
      .onFailure({ (error) -> () in
        println("Failed to post! \(error)")
      })
    }
  }
}
