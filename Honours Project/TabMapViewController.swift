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
        
        map.showsUserLocation = true
        
        //Setting up the locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getPosts();
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts() {
        let query = PFQuery(className:"PhotoTest")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            print(objects?.count)
            if(objects?.count > 0) {
                for object in objects! {
                    let post = object
                    let user = post["user"] as! String
                    let platform = post["platform"] as! String
                    let titleText = user + ", " + platform
                    let annotation = MapAnnotation(title: titleText,
                        coordinate: CLLocationCoordinate2D(latitude: post["lat"]!.doubleValue, longitude: post["lon"]!.doubleValue))
                    
                    self.map.addAnnotation(annotation)
                }
            }
        }
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
