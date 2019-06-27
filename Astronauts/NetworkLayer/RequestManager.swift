//
//  RequestManager.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import CoreLocation

enum RequestManagerError: Error {
    case urlNotFound, unrechable, noData
}

class RequestManager {
    
    /// Get list of People in space
    ///
    /// - Parameter completion: returns PeopleResponse which holds number of people in space along with there names
    class func getCurrentPeople(completion: @escaping(PeopleResponse) -> Void) {
        let urlString = Urls.peopleInSpaceUrl
        guard let url = URL(string: urlString) else {
            completion(PeopleResponse(nil, RequestManagerError.urlNotFound))
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
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
    
    /// Get current location of International space station
    ///
    /// - Parameter completion: completion returns CraftLocation response which holds coordinates for current location of craft.
    class func getCurrentLocation(completion: @escaping(CraftLocationResponse) -> Void) {
        let urlString = Urls.currentLocationUrl
        guard let url = URL(string: urlString) else {
            completion(CraftLocationResponse(nil, RequestManagerError.urlNotFound))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    completion(CraftLocationResponse(jsonData, error))
                } catch (let error){
                    completion(CraftLocationResponse(nil, error))
                }
            } else {
                completion(CraftLocationResponse(nil, error))
            }
        }.resume()
    }
    
    /// get timestamp of ISS flyover for given coordinates.
    ///
    /// - Parameters:
    ///   - location: latitudes and logitude for which the pass times required
    ///   - completion: completion block return ISSPassTimeResponse which holds 5 time stamps for when ISS will fly over current location
    class func getPassTime(location: CLLocation, completion: @escaping(ISSPassTimeResponse) -> Void) {
        
        let finalString = Urls.getPassTimeUrl(for: location)
        
        guard let url = URL(string: finalString) else {
            completion(ISSPassTimeResponse(nil, RequestManagerError.urlNotFound))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    completion(ISSPassTimeResponse(jsonData, error))
                } catch (let error) {
                    completion(ISSPassTimeResponse(nil, error))
                }
            } else {
                completion(ISSPassTimeResponse(nil, error))
            }
        }.resume()
    }
}

