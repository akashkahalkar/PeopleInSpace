//
//  PassTime.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation

struct ISSPassTime {
    private var duration: Double
    private var riseTime: Double
    var date: DateUtility
    
    var time: (hour: Double, minute: Double, seconds: Double) {
        
        return (duration / 3600,
               (duration.truncatingRemainder(dividingBy: 3600)) / 60,
               (duration.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60))
    }
    
    init(_ response: [String: Any]) {
        duration = response["duration"] as? Double ?? 0
        riseTime = response["risetime"] as? Double ?? 0
        date = DateUtility(date: riseTime)
    }
}

struct ISSPassTimeResponse {
    var result: ResponseResult = (.fail, "Unable to getData")
    
    var passes: [ISSPassTime] = []
    
    init(_ response: [String: Any]?, _ error: Error?) {
        if let response = response, let passTimeArray = response["response"] as? [[String: Any]] {
            passes = passTimeArray.map { ISSPassTime.init($0) }
            result = (.success, nil)
        }
    }
}
