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
        } else if let error = error {
            result = (.fail, error.localizedDescription)
        }
    }
}

/*
 {
    "date":"2020-08-16",
    "explanation":"In the center of this serene stellar swirl is likely a harrowing black-hole beast.  The surrounding swirl sweeps around billions of stars which are highlighted by the brightest and bluest. The breadth and beauty of the display give the swirl the designation of a grand design spiral galaxy. The central beast shows evidence that it is a supermassive black hole about 10 million times the mass of  our Sun.  This ferocious creature devours stars and gas and is surrounded by a spinning moat of hot plasma that emits blasts of X-rays. The central violent activity gives it the designation of a Seyfert galaxy. Together, this beauty and beast are cataloged as NGC 6814 and have been appearing together toward the constellation of the Eagle (Aquila) for roughly the past billion years.   Pereid Meteor Shower: Notable images submitted to APOD",
    "hdurl":"https://apod.nasa.gov/apod/image/2008/NGC6814_HubbleSchmidt_3970.jpg",
    "media_type":"image",
    "service_version":"v1",
    "title":"NGC 6814: Grand Design Spiral Galaxy from Hubble",
    "url":"https://apod.nasa.gov/apod/image/2008/NGC6814_HubbleSchmidt_960.jpg"
 }
 */

struct ImageOfTheDay {
    let explanation: String
    let title: String
    let imageURL: String
    
    var result: ResponseResult = (.fail, "Unable to load Data")
    
    init(_ response: [String: Any]?, _ error: Error?) {
        let mediaType = response?["media_type"] as? String ?? ""
        title = response?["title"] as? String ?? ""
        imageURL = response?["url"] as? String ?? ""
        explanation = response?["explanation"] as? String ?? ""
        
        if mediaType == "image" {
            result = (.success, nil)
        } else {
            result = (.fail, nil)
        }
    }
}
