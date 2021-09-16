//
//  StationTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationTests: BaseTestCase {
    
    func test_initJSON() {
        // Given
        let id = 1
        let name = "Berlin ZOB"
        let dict: [String: Any] = [
            Station.CodingKeys.id.rawValue: id,
            Station.CodingKeys.name.rawValue: name,
        ]
        let json = JSON(dict)
        
        // When
        let subject = Station(json: json)
        
        // Then
        XCTAssertEqual(subject.id, id)
        XCTAssertEqual(subject.name, name)
    }
    
}
