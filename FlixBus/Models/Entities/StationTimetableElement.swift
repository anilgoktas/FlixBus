//
//  StationTimetableElement.swift
//  StationTimetableElement
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

struct StationTimetableElement {
    
    // MARK: - Properties
    
    let lineCode: String
    let direction: String
    let dateTime: DateTime
    let briefRoute: String
    let route: [Station]
    
    // MARK: - Life Cycle
    
    init(
        lineCode: String,
        direction: String,
        dateTime: DateTime,
        briefRoute: String,
        route: [Station]
    ) {
        self.lineCode = lineCode
        self.direction = direction
        self.dateTime = dateTime
        self.briefRoute = briefRoute
        self.route = route
    }
    
    init?(json: JSON) {
        lineCode = json[CodingKeys.lineCode.rawValue].stringValue
        direction = json[CodingKeys.direction.rawValue].stringValue
        
        guard let dateTime = DateTime(json: json[CodingKeys.dateTime.rawValue]) else {
            return nil
        }
        self.dateTime = dateTime
        
        briefRoute = json[CodingKeys.briefRoute.rawValue].stringValue
        route = json[CodingKeys.route.rawValue].arrayValue.map { Station(json: $0) }
    }
    
}

// MARK: - CodingKeys

extension StationTimetableElement {
    
    enum CodingKeys: String, CodingKey {
        case lineCode = "line_code"
        case direction
        case dateTime = "datetime"
        case briefRoute = "through_the_stations"
        case route
    }
    
}
