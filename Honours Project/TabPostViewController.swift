//
//  TabPostViewController.swift
//  Honours Project
//
//  Created by Calum on 07/10/2015.
//  Copyright © 2015 Gathergood. All rights reserved.
//

import UIKit

class TabPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var locationManager = CLLocationManager();
    var photoSelected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getPhoto(sender: AnyObject) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
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
        imageView.image = image
        photoSelected = true
    }
    
    @IBAction func post(sender: AnyObject) {
        let location = locationManager.location
        
        if(location == nil){
            displayAlert("GPS Required", message: "You must enable GPS to upload a post.")
        } else {
            if (photoSelected == false){
                displayAlert("Image Required", message: "Please select an Image.")
            } else {
                let post = PFObject(className: "PhotoTest")
                post["user"] = PFUser.currentUser()?.username
                post["lat"] = locationManager.location!.coordinate.latitude
                post["lon"] = locationManager.location!.coordinate.longitude
                post["platform"] = "iOS"
                
                let imageData = imageView.image!.mediumQualityJPEGNSData
                let imageFile = PFFile(name:"UserImage.png", data:imageData)
                post["image"] = imageFile
                
                post.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    if (success) {
                        self.displayAlert("Success", message: "Your post was uploaded successfully")
                        self.resetAfterPost()
                    } else {
                        self.displayAlert("Failure", message: "Your post was uploaded unsuccessfully, please try again.")
                    }
                })
            }
        }

    }
    
    func displayAlert(title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func resetAfterPost() {
        imageView.image = UIImage(named: "camera_large.png")
        photoSelected = false;
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure you wish to logout?", preferredStyle: UIAlertControllerStyle.Alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            PFUser.logOut()
            self.view.window?.rootViewController = self.storyboard?.instantiateInitialViewController()
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        presentViewController(logoutAlert, animated: true, completion: nil)
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
