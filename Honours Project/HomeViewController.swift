//
//  HomeViewController.swift
//  Honours Project
//
//  Created by Calum on 03/04/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Hello \(PFUser.currentUser().username)!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: self)
        
    }

}
