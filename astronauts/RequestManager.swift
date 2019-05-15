//
//  RequestManager.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation

class RequestManager {
    
    class func get(completion: @escaping(PeopleResponse) -> Void) {
        let urlString = "http://api.open-notify.org/astros.json"
        guard let url = URL(string: urlString) else {
            print("unable to get request")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    completion(PeopleResponse(jsonData, error))
                } catch {
                    completion(PeopleResponse(nil, error))
                }
            } else {
              completion(PeopleResponse(nil, error))
            }
        }).resume()
    }
}
