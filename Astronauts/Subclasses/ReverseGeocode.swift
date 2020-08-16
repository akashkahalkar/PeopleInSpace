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
                return
            }
            if let address = placemarks?.first {
                let country = address.country ?? ""
                let locality = address.locality ?? ""
                let name = address.name ?? ""
                let addressString = "\(country) \(locality) \(name)"
                completion(addressString)
            } else {
                completion(nil)
            }
        }
    }
}
