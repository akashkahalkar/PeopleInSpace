//
//  Model.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation

//http://api.open-notify.org/astros.json

/*{"people": [{"name": "Oleg Kononenko", "craft": "ISS"}, {"name": "David Saint-Jacques", "craft": "ISS"}, {"name": "Anne McClain", "craft": "ISS"}], "number": 3, "message": "success"}*/


struct Astronaut {
    var name: String
    var craft: String
    
    init(_ response:[String: Any]) {
        name = response["name"] as? String ?? ""
        craft = response["craft"] as? String ?? ""
    }
}

enum ResponseStatus {
    case success, fail
}

typealias ResponseResult = (status: ResponseStatus, message: String?)

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

