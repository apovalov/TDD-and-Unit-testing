//
//  Location.swift
//  ToDoApp_TDD
//
//  Created by Macbook on 03.12.2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    var dict: [String : Any] {
        var dict: [String : Any] = [:]
        dict["name"] = name
        if let coordinate = coordinate {
            dict["latitude"] = coordinate.latitude
            dict["longitude"] = coordinate.longitude
        }
        return dict
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

extension  Location {
    typealias PlistDict = [String : Any]
    init?(dict: PlistDict) {
        self.name = dict["name"] as! String
        if
            let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard rhs.coordinate?.latitude == lhs.coordinate?.latitude &&
            rhs.coordinate?.longitude == lhs.coordinate?.longitude && lhs.name == rhs.name else { return false }
        return true
    }
}
