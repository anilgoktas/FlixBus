//
//  StationTimetable.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import Foundation

struct StationTimetable {
    typealias Element = StationTimetableElement
    
    // MARK: - Properties
    
    let arrivals: [Element]
    let departures: [Element]
    
    // MARK: - Life Cycle
    
    init(arrivals: [Element], departures: [Element]) {
        self.arrivals = arrivals
        self.departures = departures
    }
    
    init(json: JSON) {
        arrivals = json[CodingKeys.arrivals.rawValue]
            .arrayValue
            .compactMap { Element(json: $0) }
        departures = json[CodingKeys.departures.rawValue]
            .arrayValue
            .compactMap { Element(json: $0) }
    }
    
    static func makeEmpty() -> StationTimetable {
        .init(arrivals: [], departures: [])
    }
    
}

// MARK: - CodingKeys

extension StationTimetable {
    
    enum CodingKeys: String, CodingKey {
        case arrivals
        case departures
    }
    
}
