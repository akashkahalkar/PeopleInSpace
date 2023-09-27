//
//  DateUtility.swift
//  astronauts
//
//  Created by Akash kahalkar on 26/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation


final class DateUtility {
    
    private var currentDate: Date
    private let formatter = DateFormatterSingleton.shared
    
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

class DateFormatterSingleton {
    static let shared = DateFormatter()
    private init() { }
}
