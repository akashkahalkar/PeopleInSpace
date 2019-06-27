//
//  ReverseGeoCode.swift
//  astronauts
//
//  Created by Akash kahalkar on 26/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import CoreLocation

class RevereseGeocode {
    
    var locationCoordinate:  CLLocation
    private var addressString = "NA"

    lazy var geo: CLGeocoder = {
        return CLGeocoder()
    }()
    
    init(latitiude: Double, longitude: Double) {
        locationCoordinate = CLLocation(latitude: latitiude, longitude: longitude)
    }
    
    func getAddress(completion: @escaping ((String?) -> Void)) {
        geo.reverseGeocodeLocation(locationCoordinate) { (placemarks, error) in
            if (error != nil) {
                print("Reverse geocoding failure: \(error!.localizedDescription)")
                completion(nil)
            }
            let pm = placemarks! as [CLPlacemark]
            if pm.count > 0 {
                let address = placemarks![0]
                //                        print(pm.country, "country")
                //                        print(pm.locality, "locality")
                //                        print(pm.subLocality, "subLocale")
                //                        print(pm.thoroughfare, "throughtfare")
                //                        print(pm.postalCode, "postalCode")
                //                        print(pm.subThoroughfare, "subThrought")
                //                        print(pm.administrativeArea, "adminstrative")
                //                        print(pm.areasOfInterest?.description, "areaOfInteres")
                //                        print(pm.name, "name")
                //                        print(pm.ocean, "ocean")
                //                        print(pm.subAdministrativeArea, "subAdmin")
                
                
                let country = address.country ?? ""
                let locality = address.locality ?? ""
                let name = address.name ?? ""
                self.addressString = "\(country) \(locality) \(name)"
                completion(self.addressString)
            } else {
                completion(nil)
            }
        }
    }
}
