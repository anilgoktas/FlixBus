//
//  StationTimetableNetworkRouterTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus
import Combine

final class StationTimetableNetworkRouterTests: BaseTestCase {
    
    func test_fetchTimetable_shouldUseNetworkSession() {
        // Given
        let subject = StationTimetableNetworkRouter()
        let future = Just(JSON())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        network.given(.perform(urlRequest: .any, willReturn: future))
        
        // When
        _ = subject.fetchTimetable(stationID: 1)
        
        // Then
        network.verify(.perform(urlRequest: .any))
    }
    
}
