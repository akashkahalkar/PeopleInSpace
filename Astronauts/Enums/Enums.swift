//
//  Enums.swift
//  astronauts
//
//  Created by Akash kahalkar on 26/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum CollectionsCellType: Int, CaseIterable {
    case peopleCell, passTime, currentLocation, imageOfTheDay
    
    func image() -> UIImage? {
        switch self {
            
        case .peopleCell:
            return #imageLiteral(resourceName: "people")
        case .passTime:
            return #imageLiteral(resourceName: "iss")
        case .currentLocation:
            return #imageLiteral(resourceName: "issPass")
        case .imageOfTheDay:
            return #imageLiteral(resourceName: "imageOfTheDay")
        }
    }
    
    
    func title() -> String {
        switch self {
            
        case .peopleCell:
            return "People in Space"
        case .passTime:
            return "Current Location of the ISS"
        case .currentLocation:
            return "Next Pass Above You"
        case .imageOfTheDay:
            return "Astronmical Image of the Day"
        }
    }
    
    func subtitle() -> String {
        switch self {
            
        case .peopleCell:
            return "There are total of ##COUNT## people in space."
        case .passTime:
            return """
            The International Space Station (ISS) is a space station, its first component was launched into orbit in 1998.\n
            Orbital speed: 27,600 km/h\n
            Orbital period: 92.68 minutes\n
            Orbital inclination: 51.64 degrees\n
            Orbits per day: 15.54\n
            Tap the button below to see current location of space station.
            """
        case .currentLocation:
            return "Check when the ISS will travel from above you."
        case .imageOfTheDay:
            return """
            Each day a different image or photograph of our fascinating universe is featured,\n
            Along with a brief explanation written by a professional astronomer.
            """
        }
    }
}

struct Urls {
    static let peopleInSpaceUrl = "http://api.open-notify.org/astros.json"
    static let currentLocationUrl = "http://api.open-notify.org/iss-now.json"
    
    static func getPassTimeUrl(for location: CLLocation) -> String {
         let urlString = "http://api.open-notify.org/iss-pass.json?lat=##LAT##&lon=##LON##"
        
        return urlString
            .replacingOccurrences(of: "##LAT##", with: "\(location.coordinate.latitude)")
            .replacingOccurrences(of: "##LON##", with: "\(location.coordinate.longitude)")
    }
    
    static func getImageOfTheDayUrl(apiKey: String = "DEMO_KEY") -> String {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=##APIKEY##"
        return urlString.replacingOccurrences(of: "##APIKEY##", with: apiKey)
    }
    
}

/*
 Source Gradient colors: https://github.com/iLeafSolutionsPvtLtd/GradientAnimator
 */
enum FlatColors {
    case Sunrise, Amin, Maldives, DIMIGO, NeonLife, BlueLagoon, Celestial, Kyoopal, SolidStone, GentleCare
    
    func colors() -> [UIColor] {
        switch  self {
        case .Sunrise:
            return [#colorLiteral(red: 0.9411764706, green: 0.5960784314, blue: 0, alpha: 1), #colorLiteral(red: 0.8941176471, green: 0.5764705882, blue: 0.1176470588, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.2745098039, blue: 0.2745098039, alpha: 1), #colorLiteral(red: 1, green: 0.3450980392, blue: 0.3450980392, alpha: 1)]
        case .Amin:
            return [#colorLiteral(red: 0.1450980392, green: 0.4588235294, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.1450980392, green: 0.4274509804, blue: 0.9019607843, alpha: 1), #colorLiteral(red: 0.4352941176, green: 0.1137254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4156862745, green: 0.06666666667, blue: 0.7960784314, alpha: 1)]
        case .Maldives:
            return [#colorLiteral(red: 0, green: 0.9490196078, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 0.07058823529, green: 0.9019607843, blue: 0.9411764706, alpha: 1), #colorLiteral(red: 0.368627451, green: 0.6470588235, blue: 0.8901960784, alpha: 1), #colorLiteral(red: 0.3098039216, green: 0.6745098039, blue: 0.9960784314, alpha: 1)]
        case .DIMIGO:
            return [#colorLiteral(red: 0.9960784314, green: 0.3176470588, blue: 0.5882352941, alpha: 1), #colorLiteral(red: 0.9254901961, green: 0.2862745098, blue: 0.5411764706, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.3647058824, blue: 0.3058823529, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.4392156863, blue: 0.3843137255, alpha: 1)]
        case .NeonLife:
            return [#colorLiteral(red: 0, green: 0.8901960784, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.07843137255, green: 0.7960784314, blue: 0.6274509804, alpha: 1), #colorLiteral(red: 0.5333333333, green: 0.8078431373, blue: 0.2901960784, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.8823529412, blue: 0.3647058824, alpha: 1)]
        case .BlueLagoon:
            return [#colorLiteral(red: 0.2, green: 0.03137254902, blue: 0.4039215686, alpha: 1), #colorLiteral(red: 0.2666666667, green: 0.1529411765, blue: 0.4039215686, alpha: 1), #colorLiteral(red: 0.1411764706, green: 0.5725490196, blue: 0.5764705882, alpha: 1), #colorLiteral(red: 0.1882352941, green: 0.8117647059, blue: 0.8156862745, alpha: 1)]
        case .Celestial:
            return [#colorLiteral(red: 0.007843137255, green: 0.3137254902, blue: 0.7725490196, alpha: 1), #colorLiteral(red: 0.168627451, green: 0.3450980392, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.7215686275, green: 0.2196078431, blue: 0.4823529412, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.2470588235, blue: 0.5529411765, alpha: 1)]
        case .Kyoopal:
            return [#colorLiteral(red: 0.1411764706, green: 0.8235294118, blue: 0.5725490196, alpha: 1), #colorLiteral(red: 0.1215686275, green: 0.7725490196, blue: 0.5333333333, alpha: 1), #colorLiteral(red: 0.7607843137, green: 0.2941176471, blue: 0.7137254902, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0.3450980392, blue: 0.7843137255, alpha: 1)]
        case .SolidStone:
            return [#colorLiteral(red: 0.3176470588, green: 0.4980392157, blue: 0.6431372549, alpha: 1), #colorLiteral(red: 0.2745098039, green: 0.4235294118, blue: 0.5450980392, alpha: 1), #colorLiteral(red: 0.1764705882, green: 0.2352941176, blue: 0.2784313725, alpha: 1), #colorLiteral(red: 0.1411764706, green: 0.2235294118, blue: 0.2862745098, alpha: 1)]
        case .GentleCare:
            return [#colorLiteral(red: 1, green: 0.6862745098, blue: 0.7411764706, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.6117647059, blue: 0.662745098, alpha: 1), #colorLiteral(red: 0.9137254902, green: 0.6509803922, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 1, green: 0.7647058824, blue: 0.6274509804, alpha: 1)]
        }
    }
}

enum GradientPoints: Int {
    case left
    case top
    case right
    case bottom
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    var point: CGPoint {
        switch self {
        case .top: return CGPoint(x: 0.5, y: 0.0)
        case .left: return CGPoint(x: 0.0, y: 0.5)
        case .right: return CGPoint(x: 1.0, y: 0.5)
        case .bottom: return CGPoint(x: 0.5, y: 1.0)
        case .topLeft: return CGPoint(x: 0.0, y: 0.0)
        case .topRight: return CGPoint(x: 1.0, y: 0.0)
        case .bottomLeft: return CGPoint(x: 0.0, y: 1.0)
        case .bottomRight: return CGPoint(x: 1.0, y: 1.0)
        }
    }
}
