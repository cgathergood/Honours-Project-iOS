//
//  HomeViewController.swift
//  Honours Project
//
//  Created by Calum on 03/04/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func gpsButton(sender: AnyObject) {
        
        var name:NSString = PFUser.currentUser()!.username!
        
        if(PFUser.currentUser() != nil){
            welcomeLabel.text = "Hello \(name)"
        }
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var location = locationManager.location
        displayAlert("GPS", message: "Latitude: \(location.coordinate.latitude) \n Longitude: \(location.coordinate.longitude)")
        
        

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        locationManager.stopUpdatingLocation()
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    func displayAlert(title:String, message:String){
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
