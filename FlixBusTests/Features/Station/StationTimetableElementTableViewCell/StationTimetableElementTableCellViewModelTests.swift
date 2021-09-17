//
//  StationTimetableElementTableCellViewModelTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationTimetableElementTableCellViewModelTests: BaseTestCase {
    
    func test_initElement() throws {
        // Given
        let dateTime = try DateTime.makeStub()
        let element = StationTimetableElement.makeExample1(dateTime: dateTime)
        let timeString = "Unit testing time string"
        dateTimeFormatter.given(.timeString(for: .any, willReturn: timeString))
        
        // When
        let subject = StationTimetableElementTableCellViewModel(element: element)
        
        // Then
        XCTAssertEqual(subject.timeString, timeString)
        XCTAssertEqual(subject.lineAndDirectionString, element.lineAndDirection)
        XCTAssertEqual(subject.briefRouteString, element.briefRoute)
    }
    
}
