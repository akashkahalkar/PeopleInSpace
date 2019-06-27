//
//  Model.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import CoreLocation

// ----- Global Entities
enum ResponseStatus {
    case success, fail
}

typealias ResponseResult = (status: ResponseStatus, message: String?)
//----- End Global entities

struct CraftLocation {
    
    private var timeStamp: Double = 0
    private var latitudeString: String = ""
    private var longitudeString: String = ""
    
    lazy var date: Date = {
       return Date(timeIntervalSince1970: timeStamp)
    }()
    
    var location: CLLocation {
        return CLLocation(latitude: Double(latitudeString) ?? 0, longitude: Double(longitudeString) ?? 0)
    }
    
    init(_ response: [String: Any]) {
        timeStamp       = response["timestamp"] as? Double ?? 0
        let position    = response["iss_position"] as? [String: Any]
        latitudeString  = position?["latitude"] as? String ?? ""
        longitudeString = position?["longitude"] as? String ?? ""
    }
}

struct CraftLocationResponse {
    var result: ResponseResult = (.fail, "Unable to load data")
    var craftLocation = CraftLocation([: ])
    
    init(_ response: [String: Any]?, _ error: Error?) {
        
        if let message = response?["message"] as? String, message == "success" {
            craftLocation = CraftLocation.init(response!)
            result = (.success, nil)
        }
    }
}




