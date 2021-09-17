//
//  StationTimetableElement.swift
//  StationTimetableElement
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

/// Also known as `ride`, `trip` or `line`.
struct StationTimetableElement {
    
    // MARK: - Properties
    
    let lineCode: String
    let dateTime: DateTime
    let briefRoute: String
    let lineAndDirection: String
    let route: [Station]
    
    // MARK: - Life Cycle
    
    init(
        lineCode: String,
        dateTime: DateTime,
        briefRoute: String,
        lineAndDirection: String,
        route: [Station]
    ) {
        self.lineCode = lineCode
        self.dateTime = dateTime
        self.briefRoute = briefRoute
        self.lineAndDirection = lineAndDirection
        self.route = route
    }
    
    init?(json: JSON) {
        lineCode = json[CodingKeys.lineCode.rawValue].stringValue
        
        guard let dateTime = DateTime(json: json[CodingKeys.dateTime.rawValue]) else {
            return nil
        }
        self.dateTime = dateTime
        
        briefRoute = json[CodingKeys.briefRoute.rawValue].stringValue
        lineAndDirection = json[CodingKeys.lineAndDirection.rawValue].stringValue
        route = json[CodingKeys.route.rawValue].arrayValue.map { Station(json: $0) }
    }
    
}

// MARK: - CodingKeys

extension StationTimetableElement {
    
    enum CodingKeys: String, CodingKey {
        case lineCode = "line_code"
        case dateTime = "datetime"
        case briefRoute = "through_the_stations"
        case lineAndDirection = "line_direction"
        case route
    }
    
}
