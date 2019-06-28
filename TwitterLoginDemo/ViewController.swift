//
//  ViewController.swift
//  TwitterLoginDemo
//
//  Created by webwerks on 28/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    // MARK: IBOutlet Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
  
    var loginButton: TWTRLogInButton!
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
       signIn()
    }

    // MARK: Custom Function
   
    func signIn() {
        loginButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let client = TWTRAPIClient()
                client.loadUser(withID: unwrappedSession.userID, completion: { (user, error) in
                    self.nameLabel.text = user?.name
                    self.userNameLabel.text = unwrappedSession.userName
                    if let imageUrl = user?.profileImageURL {
                        let url = URL(string: imageUrl)
                        let data = try? Data.init(contentsOf: url!)
                        self.profileImageView.image = UIImage(data: data!)
                    }
                    else {
                        print("Profile Image not present")
                    }
                })
            }
            else {
                print("Login Error")
            }
        }
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
}

