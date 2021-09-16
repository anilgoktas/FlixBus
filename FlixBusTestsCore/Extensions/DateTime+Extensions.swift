//
//  DateTime+Extensions.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

extension DateTime {
    
    static func makeStub(
        timestamp: Int = 1631556900,
        timeZoneAbbreviation: String = "GMT+02:00"
    ) throws -> DateTime {
        let timeZone = try XCTUnwrap(TimeZone(abbreviation: "GMT+02:00"))
        return DateTime(timestamp: timestamp, timeZone: timeZone)
    }
    
}
