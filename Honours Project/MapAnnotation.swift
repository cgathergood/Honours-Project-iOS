//
//  MapAnnotation.swift
//  Honours Project
//
//  Created by Calum on 15/09/2015.
//  Copyright (c) 2015 Gathergood. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
};