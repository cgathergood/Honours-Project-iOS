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
        
        let name:NSString = PFUser.currentUser()!.username!
        
        if(PFUser.currentUser() != nil){
            welcomeLabel.text = "Hello \(name)"
        }
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    } 
    
    // Get photo
    @IBOutlet weak var photoView: UIImageView!
    
    @IBAction func getPhoto(sender: AnyObject) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default) { action -> Void in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(image, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose Exisiting Photo", style: .Default) { action -> Void in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(image, animated: true, completion: nil)

        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        photoView.image = image
    }
    
    
    @IBAction func gpsButton(sender: AnyObject) {
        
        let location = locationManager.location
        
        if(location != nil){
            displayAlert("GPS", message: "Latitude: \(location!.coordinate.latitude) \n Longitude: \(location!.coordinate.longitude)")
        } else {
            displayAlert("Error", message: "Can't find your location")
        }
    }
    
    // Upload
    @IBAction func postUpload(sender: AnyObject) {
        let post = PFObject(className: "PhotoTest")
        post["user"] = PFUser.currentUser()!.username!
        post["lat"] = locationManager.location!.coordinate.latitude
        post["lon"] = locationManager.location!.coordinate.longitude
        post["platform"] = "iOS"
        
        //Image
        
        let imageData = UIImagePNGRepresentation(photoView.image!)
        let imageFile = PFFile(name:"UserImage.png", data:imageData!)
        post["image"] = imageFile
        
        post.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            if (success) {
                self.displayAlert("Success", message: "Your post was uploaded successfully")
            } else {
                self.displayAlert("Failure", message: "Your post was uploaded unsuccessfully, please try again.")
            }
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }

    @IBAction func MapButton(sender: UIButton) {
        self.performSegueWithIdentifier("map", sender: self)
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
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // Closes keyboard by tapping anywhere else
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
