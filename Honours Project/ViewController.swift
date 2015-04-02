//
//  ViewController.swift
//  Honours Project
//
//  Created by Calum on 23/03/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(sender: AnyObject) {
        
        var error = ""
        
        if username.text == "" || password.text == ""{
            error = "Please fill in all fields."
        }
        
        if error != "" {
            displayAlert("Oops! Something went wrong.", message: error)
        } else {
            // Log in goes here
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //        var test = PFObject(className: "Test")
        //        test.setObject("iOS", forKey: "OperatingSystem")
        //        test.saveInBackgroundWithBlock{
        //            (success: Bool!, error: NSError!) -> Void in
        //
        //            if(success==true){
        //                println("Parse Object created: \(test.objectId)")
        //            } else {
        //                println(error)
        //            }
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title:String, message:String){
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

