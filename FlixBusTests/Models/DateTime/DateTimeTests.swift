//
//  DateTimeTests.swift
//  DateTimeTests
//
//  Created by Anil Goktas on 9/14/21.
//

import XCTest
@testable import FlixBus

final class DateTimeTests: BaseTestCase {
    
    func test_initTimestampTimeZone() throws {
        // Given
        let timestamp = 1631556900
        let timeZone = try XCTUnwrap(TimeZone(abbreviation: "GMT+02:00"))
        
        // When
        let subject = DateTime(timestamp: timestamp, timeZone: timeZone)
        
        // Then
        XCTAssertEqual(subject.date.timeIntervalSince1970, TimeInterval(timestamp))
        XCTAssertEqual(subject.timeZone.abbreviation(), "GMT+2")
    }
    
    func test_initTimestampAbbreviation_success() throws {
        // Given
        let timestamp = 1631556900
        let timeZoneAbbreviation = "GMT+02:00"
        
        // When
        let subject = try XCTUnwrap(
            DateTime(timestamp: timestamp, timeZoneAbbreviation: timeZoneAbbreviation)
        )
        
        // Then
        XCTAssertEqual(subject.date.timeIntervalSince1970, TimeInterval(timestamp))
        XCTAssertEqual(subject.timeZone.abbreviation(), "GMT+2")
    }
    
    func test_initTimestampAbbreviation_failure() {
        // Given
        let timestamp = 1631556900
        
        // When
        let subject = DateTime(timestamp: timestamp, timeZoneAbbreviation: "")
        
        // Then
        XCTAssertNil(subject)
    }
    
    func test_initJSON_success() throws {
        // Given
        let timestamp = 1631556900
        let dict: [String: Any] = [
            DateTime.CodingKeys.date.rawValue: timestamp,
            DateTime.CodingKeys.timeZoneAbbreviation.rawValue: "GMT+02:00"
        ]
        let json = JSON(dict)
        
        // When
        let subject = try XCTUnwrap(DateTime(json: json))
        
        // Then
        XCTAssertEqual(subject.date.timeIntervalSince1970, TimeInterval(timestamp))
        XCTAssertEqual(subject.timeZone.abbreviation(), "GMT+2")
    }
    
    func test_initJSON_failure() {
        // Given
        let json = JSON()
        
        // When
        let subject = DateTime(json: json)
        
        // Then
        XCTAssertNil(subject)
    }
    
    func test_initUsingDecodedJSON() throws {
        // Given
        let originalSubject = try DateTime.makeStub()
        let json = JSON(originalSubject.dictionaryValue)
        
        // When
        let subject = try XCTUnwrap(DateTime(json: json))
        
        // Then
        XCTAssertEqual(originalSubject.date.timeIntervalSince1970, subject.date.timeIntervalSince1970)
        XCTAssertEqual(originalSubject.timeZone, subject.timeZone)
    }
    
}
