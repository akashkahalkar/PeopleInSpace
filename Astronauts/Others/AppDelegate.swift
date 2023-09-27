//
//  AppDelegate.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //added caching
        let temp = NSTemporaryDirectory()
        let cache = URLCache(memoryCapacity: 2500000, diskCapacity: 5000000, diskPath: temp)
        URLCache.shared = cache
        return true
    }
}

