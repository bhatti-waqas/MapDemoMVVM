//
//  POI.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 16/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation

public class Coordinate: NSObject, Codable {
    @objc var latitude: Double
    @objc var longitude: Double
    
    @objc public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public class POI: NSObject, Codable {
    @objc var id: Int
    @objc var fleetType: String
    @objc var heading: Double
    @objc var coordinate: Coordinate
    
    /// Default init method, had to write it to able to help making mock objects.
    public init(_ id: Int = 0, fleetType: String = "", heading: Double = 0.0, coordinate: Coordinate = Coordinate(latitude: 0.0, longitude: 0.0))
    {
        self.id = id
        self.fleetType = fleetType
        self.heading = heading
        self.coordinate = coordinate
    }
}
