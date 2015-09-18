//
//  MapViewController.swift
//  Honours Project
//
//  Created by Calum on 06/08/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        
        map.showsUserLocation = true
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getPosts();
        
    }
    @IBAction func zoomIn(sender: AnyObject) {
        zoomOnUser()
    }
    
    func zoomOnUser() {
        let userLocation = map.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location.coordinate, 2000, 2000)
        
        map.setRegion(region, animated: true)
    }
    
    func getPosts() {
        var query = PFQuery(className:"PhotoTest")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            println(objects?.count)
            if(objects?.count > 0) {
                for object in objects! {
                    var post:PFObject = object as! PFObject
                    println(post)
                    var user = post["user"] as! String
                    var platform = post["platform"] as! String
                    var titleText = user + ", " + platform
                    let annotation = MapAnnotation(title: titleText,
                        coordinate: CLLocationCoordinate2D(latitude: post["lat"]!.doubleValue, longitude: post["lon"]!.doubleValue))
                    
                    self.map.addAnnotation(annotation)
                }
                println(objects?.count)
            }
        }
    }
}