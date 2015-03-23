//
//  ViewController.swift
//  Honours Project
//
//  Created by Calum on 23/03/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Parse.setApplicationId("nFHu3bnj37q5vzWkItvJutUFOPMLwjC1HbiiAXiC", clientKey: "TO9nrLJAi0w7X9pipEMjf1XgftWgfkAnuKkdhq6e")
        
        var test = PFObject(className: "Test")
        test.setObject("iOS", forKey: "OperatingSystem")
        test.saveInBackgroundWithBlock{
            (success: Bool!, error: NSError!) -> Void in
            
            if(success==true){
                println("Parse Object created: \(test.objectId)")
            } else {
                println(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

