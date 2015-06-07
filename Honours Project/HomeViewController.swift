//
//  HomeViewController.swift
//  Honours Project
//
//  Created by Calum on 03/04/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var name:NSString = PFUser.currentUser()!.username!
        
        if(PFUser.currentUser() != nil){
            welcomeLabel.text = "Hello \(name)"
        }
    } 
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBAction func getPhoto(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        photoView.image = image
    }
    
    @IBAction func gpsButton(sender: AnyObject) {
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var location = locationManager.location
        
        if(location != nil){
            displayAlert("GPS", message: "Latitude: \(location.coordinate.latitude) \n Longitude: \(location.coordinate.longitude)")
        } else {
            displayAlert("Error", message: "Can't find your location")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
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
