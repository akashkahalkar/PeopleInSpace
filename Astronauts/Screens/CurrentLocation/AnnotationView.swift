//
//  AnnotationView.swift
//  astronauts
//
//  Created by Akash kahalkar on 20/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import MapKit

final class CraftAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = "ISS"
        super.init()
    }
}
