//
//  Astronauts.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation

struct Astronaut {
    var name: String
    var craft: String
    
    init(_ response: [String: Any]) {
        name = response["name"] as? String ?? ""
        craft = response["craft"] as? String ?? ""
    }
}

struct PeopleResponse {
    var peoples: [Astronaut] = []
    var result: ResponseResult = (.fail, "Unable to load Data")
    
    init(_ response: [String: Any]?,_ error: Error?) {
        
        if let peopleArray = response?["people"] as? [[String: Any]] {
            peoples = peopleArray.map({Astronaut.init($0)})
            result = (.success, nil)
        }
    }
}
