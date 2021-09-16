//
//  StationTimetableElementTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationTimetableElementTests: BaseTestCase {
    
    func test_initJSON_failure() {
        // Given
        let json = JSON()
        
        // When
        let subject = StationTimetableElement(json: json)
        
        // Then
        XCTAssertNil(subject)
    }
    
    func test_initJSON_success() throws {
        // Given
        let dateTime = try DateTime.makeStub()
        let dict: [String: Any] = [
            StationTimetableElement.CodingKeys.dateTime.rawValue: dateTime.dictionaryValue
        ]
        let json = JSON(dict)
        
        // When
        let subject = try XCTUnwrap(StationTimetableElement(json: json))
        
        // Then
        XCTAssertEqual(subject.dateTime.timeZone, dateTime.timeZone)
        XCTAssertTrue(subject.route.isEmpty)
    }
    
}
