//
//  DateUtility.swift
//  astronauts
//
//  Created by Akash kahalkar on 26/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation


class DateUtility {
    
    var currentDate: Date
    var formatter = DateFormatter()
    
    init(date: Double) {
        currentDate = Date(timeIntervalSince1970: date)
    }
    
    func getShortTime() -> String {
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: currentDate)
    }
    
    func getDate() -> String {
        formatter.dateFormat = "MMM - dd, YYYY"
        return formatter.string(from: currentDate)
    }
}
