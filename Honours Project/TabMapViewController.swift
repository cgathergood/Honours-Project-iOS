//
//  TabMapViewController.swift
//  Honours Project
//
//  Created by Calum on 07/10/2015.
//  Copyright © 2015 Gathergood. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TabMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.map.delegate = self
        
        map.showsUserLocation = true
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getPosts();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts() {
        let query = PFQuery(className:"PhotoTest")
        query.limit = 1
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            print(objects?.count)
            if(objects?.count > 0) {
                for object in objects! {
                    let post = object
                    let user = post["user"] as! String
                    let platform = post["platform"] as! String
                    let image = post["image"] as! PFFile
                    let titleText = user + ", " + platform
                    
                    let customAnnotation = CustomMapAnnotation()
                    customAnnotation.title = titleText
                    customAnnotation.coordinate = CLLocationCoordinate2D(latitude: post["lat"]!.doubleValue, longitude: post["lon"]!.doubleValue)
                    customAnnotation.userImage = image
                    
                    
                    self.map.addAnnotation(customAnnotation)
                }
            }
        }
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
    
    @IBAction func refresh(sender: AnyObject) {
        getPosts()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomMapAnnotation){
            return nil
        }
        
        let reuseId = "test"
        
        var customView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if customView == nil {
            customView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            customView?.canShowCallout = true
            customView?.image = UIImage(named: "")
        } else {
            customView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomMapAnnotation
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        imageView.layer.masksToBounds = true
        
        customPointAnnotation.userImage.getDataInBackgroundWithBlock{
            (imageData, error) -> Void in
            
            if error == nil {
                let image = UIImage(data: imageData!)
                imageView.image = image
                customView?.leftCalloutAccessoryView = imageView
            }
            
        }
        
        return customView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
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
