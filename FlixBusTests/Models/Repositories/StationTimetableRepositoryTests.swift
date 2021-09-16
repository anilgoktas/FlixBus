//
//  StationTimetableRepositoryTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus
import Combine

final class StationTimetableRepositoryTests: BaseTestCase {
    
    // MARK: - Properties
    
    let networkRouter = StationTimetableNetworkRoutingMock()
    
    // MARK: - Factory
    
    private func makeSubject(
        station: Station = .berlinZOB
    ) -> StationTimetableRepository {
        .init(station: station, networkRouter: networkRouter)
    }
    
}

// MARK: - Tests

extension StationTimetableRepositoryTests {
    
    func test_configure_shouldUseNetworkRouter() {
        // Given
        let station = Station.munichZOB
        let future = StationTimetableNetworkRouter.makeStubFetchPublisher()
        networkRouter.given(.fetchTimetable(stationID: .value(station.id), willReturn: future))
        let subject = makeSubject(station: station)
        
        // When
        subject.configure { }
        
        // Then
        networkRouter.verify(.fetchTimetable(stationID: .value(station.id)))
    }
    
    func test_configure_networkFailure_shouldConfigureEmpty() {
        // Given
        enum TestError: Error { case reason }
        let future = StationTimetableNetworkRouter.makeStubFetchPublisher(error: TestError.reason)
        networkRouter.given(.fetchTimetable(stationID: .any, willReturn: future))
        let subject = makeSubject()
        
        // When
        subject.configure { }
        
        // Then
        XCTAssertTrue(subject.arrivals.isEmpty)
        XCTAssertTrue(subject.departures.isEmpty)
    }
    
    func test_configure_shouldSortArrivals() throws {
        // Given
        let timeZone = try XCTUnwrap(TimeZone(abbreviation: "GMT+2:00"))
        let olderDateTime = DateTime(
            timestamp: Int(Date.make(year: 2021, month: 9, day: 12).timeIntervalSince1970),
            timeZone: timeZone
        )
        let closerDateTime = DateTime(
            timestamp: Int(Date.make(year: 2021, month: 9, day: 15).timeIntervalSince1970),
            timeZone: timeZone
        )
        let olderElement = StationTimetableElement.makeExample1(dateTime: olderDateTime)
        let closerElement = StationTimetableElement.makeExample2(dateTime: closerDateTime)
        let timetable = StationTimetable(arrivals: [closerElement, olderElement], departures: [])
        let future = StationTimetableNetworkRouter.makeStubFetchPublisher(.init(timetable: timetable))
        networkRouter.given(.fetchTimetable(stationID: .any, willReturn: future))
        let subject = makeSubject()
        
        // When
        subject.configure { }
        
        // Then
        XCTAssertTrue(subject.departures.isEmpty)
        XCTAssertEqual(subject.arrivals.count, 2)
        let firstArrivalElement = try XCTUnwrap(subject.arrivals.first)
        let secondArrivalElement = try XCTUnwrap(subject.arrivals.last)
        XCTAssertEqual(firstArrivalElement.dateTime.date.timeIntervalSince1970, olderDateTime.date.timeIntervalSince1970)
        XCTAssertEqual(secondArrivalElement.dateTime.date.timeIntervalSince1970, closerDateTime.date.timeIntervalSince1970)
    }
    
    func test_configure_shouldSortDepartures() throws {
        // Given
        let timeZone = try XCTUnwrap(TimeZone(abbreviation: "GMT+2:00"))
        let olderDateTime = DateTime(
            timestamp: Int(Date.make(year: 2021, month: 9, day: 12).timeIntervalSince1970),
            timeZone: timeZone
        )
        let closerDateTime = DateTime(
            timestamp: Int(Date.make(year: 2021, month: 9, day: 15).timeIntervalSince1970),
            timeZone: timeZone
        )
        let olderElement = StationTimetableElement.makeExample1(dateTime: olderDateTime)
        let closerElement = StationTimetableElement.makeExample2(dateTime: closerDateTime)
        let timetable = StationTimetable(arrivals: [], departures: [closerElement, olderElement])
        let future = StationTimetableNetworkRouter.makeStubFetchPublisher(.init(timetable: timetable))
        networkRouter.given(.fetchTimetable(stationID: .any, willReturn: future))
        let subject = makeSubject()
        
        // When
        subject.configure { }
        
        // Then
        XCTAssertTrue(subject.arrivals.isEmpty)
        XCTAssertEqual(subject.departures.count, 2)
        let firstArrivalElement = try XCTUnwrap(subject.arrivals.first)
        let secondArrivalElement = try XCTUnwrap(subject.arrivals.last)
        XCTAssertEqual(firstArrivalElement.dateTime.date.timeIntervalSince1970, olderDateTime.date.timeIntervalSince1970)
        XCTAssertEqual(secondArrivalElement.dateTime.date.timeIntervalSince1970, closerDateTime.date.timeIntervalSince1970)
    }
    
}
