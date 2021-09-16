//
//  StationTimetableTests.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationTimetableTests: BaseTestCase {
    
    func test_makeEmpty() {
        // Given & When
        let subject = StationTimetable.makeEmpty()
        
        // Then
        XCTAssertTrue(subject.arrivals.isEmpty)
        XCTAssertTrue(subject.departures.isEmpty)
    }
    
}
