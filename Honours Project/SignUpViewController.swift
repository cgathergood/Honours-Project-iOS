//
//  SignUpViewController.swift
//  Honours Project
//
//  Created by Calum on 02/04/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    
    @IBAction func signIp(sender: AnyObject) {
        
        var error = ""
        
        if username.text == "" || password1.text == "" || password2.text == "" {
            error = "Please fill in all fields."
        } else if password1.text != password2.text {
            error = "Passwords do not match."
        }
        
        if error != "" {
            var alert = UIAlertController(title: "Oops! Something went wrong.", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
