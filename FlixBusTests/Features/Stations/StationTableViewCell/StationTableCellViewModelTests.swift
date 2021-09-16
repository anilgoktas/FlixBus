//
//  StationTableCellViewModelTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationTableCellViewModelTests: BaseTestCase {
    
    func test_initStation() {
        // Given
        let station = Station.berlinZOB
        
        // When
        let subject = StationTableCellViewModel(station: station)
        
        // Then
        XCTAssertEqual(subject.name, station.name)
    }
    
}
