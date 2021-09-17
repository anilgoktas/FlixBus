//
//  StationTimetableElement+Extensions.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

extension StationTimetableElement {
    
    static func makeExample1(
        dateTime: DateTime,
        route: [Station] = []
    ) -> StationTimetableElement {
        StationTimetableElement(
            lineCode: "L041",
            dateTime: dateTime,
            briefRoute: "Berlin central bus station → Berlin Südkreuz → Berlin Airport BER, T 1/2 → Poznań",
            lineAndDirection: "Route 041 direction Poznań",
            route: route
        )
    }
    
    static func makeExample2(
        dateTime: DateTime,
        route: [Station] = []
    ) -> StationTimetableElement {
        StationTimetableElement(
            lineCode: "L050",
            dateTime: dateTime,
            briefRoute: "Berlin central bus station → Hamburg ZOB",
            lineAndDirection: "Route 050 direction Hamburg ZOB",
            route: route
        )
    }
    
    static func makeExample3(
        dateTime: DateTime,
        route: [Station] = []
    ) -> StationTimetableElement {
        StationTimetableElement(
            lineCode: "N81",
            dateTime: dateTime,
            briefRoute: "Berlin central bus station → Hanover → Enschede → Arnhem → Nijmegen → Eindhoven → Antwerp → Brussels-North station",
            lineAndDirection: "Route N81 direction Brussels-North station",
            route: route
        )
    }
    
}
