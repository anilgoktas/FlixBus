//
//  DateTimeFormattingTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class DateTimeFormattingTests: BaseTestCase {
    
    // MARK: - Tests
    
    func test_dateString() throws {
        // Given
        let timestamp = 1631556900
        let timeZone = try XCTUnwrap(TimeZone(abbreviation: "GMT+02:00"))
        let dateTime = DateTime(timestamp: timestamp, timeZone: timeZone)
        locale = try XCTUnwrap(Locale(identifier: "DE"))
        let subject = DateTimeFormatter()
        
        // When
        let dateString = subject.dateString(for: dateTime)
        
        // Then
        XCTAssertEqual(dateString, "13.09.21", "Date string should be same with DE locale")
    }
    
    func test_timeString() throws {
        // Given
        let timestamp = 1631556900
        let timeZone = try XCTUnwrap(TimeZone(abbreviation: "GMT+02:00"))
        let dateTime = DateTime(timestamp: timestamp, timeZone: timeZone)
        locale = try XCTUnwrap(Locale(identifier: "DE"))
        let subject = DateTimeFormatter()
        
        // When
        let dateString = subject.timeString(for: dateTime)
        
        // Then
        XCTAssertEqual(dateString, "20:15", "Time string should be same with DE locale")
    }
    
}
