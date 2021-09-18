//
//  StationViewModelTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationViewModelTests: BaseTestCase {
    
    // MARK: - Properties
    
    private let repository = StationTimetableRepositoryProtocolMock()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository.given(.arrivals(getter: []))
        repository.given(.departures(getter: []))
    }
    
    // MARK: - Factory
    
    private func makeSubject() -> StationViewModel {
        .init(repository: repository)
    }
    
}

// MARK: - Tests

extension StationViewModelTests {
    
    func test_init_initialAndComputedProperties() {
        // Given
        let station = Station.berlinZOB
        repository.given(.station(getter: station))
        
        // When
        let subject = makeSubject()
        
        // Then
        XCTAssertEqual(subject.scheduleType, .arrivals)
        XCTAssertNil(subject.onUpdate)
        XCTAssertEqual(subject.title, station.name)
        XCTAssertEqual(subject.numberOfSections, 0)
    }
    
    func test_scheduleTypeDidSet_arrivals_shouldUpdateDataSourceAndCallOnUpdate() {
        // Given
        let subject = makeSubject()
        var didCallOnUpdate = false
        subject.onUpdate = { didCallOnUpdate = true }
        
        // When
        subject.scheduleType = .arrivals
        
        // Then
        XCTAssertEqual(subject.scheduleType, .arrivals)
        XCTAssertTrue(didCallOnUpdate)
        repository.verify(.arrivals)
        repository.verify(.departures, count: 0)
    }
    
    func test_scheduleTypeDidSet_departures_shouldUpdateDataSourceAndCallOnUpdate() {
        // Given
        let subject = makeSubject()
        var didCallOnUpdate = false
        subject.onUpdate = { didCallOnUpdate = true }
        
        // When
        subject.scheduleType = .departures
        
        // Then
        XCTAssertEqual(subject.scheduleType, .departures)
        XCTAssertTrue(didCallOnUpdate)
        repository.verify(.departures)
        repository.verify(.arrivals, count: 0)
    }
    
    func test_configureDataSource_shouldUseRepository() {
        // Given
        repository.perform(.configure(.any, perform: { closure in
            closure()
        }))
        let subject = makeSubject()
        
        // When
        subject.configureDataSource()
        
        // Then
        repository.verify(.configure(.any))
        repository.verify(.arrivals)
        repository.verify(.departures, count: 0)
    }
    
    func test_configureDataSource_singleSection() throws {
        // Given
        let arrivalDateTime = try DateTime.makeStub()
        let arrivalElement1 = StationTimetableElement.makeExample1(dateTime: arrivalDateTime)
        let arrivalElement2 = StationTimetableElement.makeExample2(dateTime: arrivalDateTime)
        repository.given(.arrivals(getter: [arrivalElement1, arrivalElement2]))
        repository.perform(.configure(.any, perform: { closure in
            closure()
        }))
        let dateString = "Unit-Testing/Date/String"
        dateTimeFormatter.given(.dateString(for: .any, willReturn: dateString))
        let timeString = "Unit-Testing:Time-String"
        dateTimeFormatter.given(.timeString(for: .any, willReturn: timeString))
        
        // When
        let subject = makeSubject()
        subject.configureDataSource()
        
        // Then
        dateTimeFormatter.verify(.dateString(for: .any))
        XCTAssertEqual(subject.numberOfSections, 1)
        XCTAssertEqual(subject.headerViewModel(section: 0).dateString, dateString)
        XCTAssertEqual(subject.numberOfRowsInSection(0), 2)
        XCTAssertEqual(
            subject.cellViewModel(indexPath: IndexPath(row: 0, section: 0)).timeString,
            timeString
        )
        dateTimeFormatter.verify(.timeString(for: .any))
    }
    
    func test_configureDataSource_multipleSections() throws {
        // Given
        let date1 = Date.make(year: 2021, month: 9, day: 15)
        let departureDateTime1 = try DateTime.makeStub(
            timestamp: Int(date1.timeIntervalSince1970)
        )
        let departureElement1 = StationTimetableElement.makeExample1(dateTime: departureDateTime1)
        
        let date2 = Date.make(year: 2021, month: 9, day: 17)
        let departureDateTime2 = try DateTime.makeStub(
            timestamp: Int(date2.timeIntervalSince1970)
        )
        let departureElement2 = StationTimetableElement.makeExample2(dateTime: departureDateTime2)
        repository.given(.departures(getter: [departureElement1, departureElement2]))
        
        let dateString1 = "Unit-Testing/Date/String-1"
        dateTimeFormatter.given(
            .dateString(
                for: .matching({ $0.date.timeIntervalSince1970 == date1.timeIntervalSince1970 }),
                willReturn: dateString1
            )
        )
        let dateString2 = "Unit-Testing/Date/String-2"
        dateTimeFormatter.given(
            .dateString(
                for: .matching({ $0.date.timeIntervalSince1970 == date2.timeIntervalSince1970 }),
                willReturn: dateString2
            )
        )
        
        let timeString = "Unit-Testing:Time-String"
        dateTimeFormatter.given(.timeString(for: .any, willReturn: timeString))
        
        // When
        let subject = makeSubject()
        subject.scheduleType = .departures
        
        // Then
        dateTimeFormatter.verify(.dateString(for: .any))
        XCTAssertEqual(subject.numberOfSections, 2)
        XCTAssertEqual(subject.headerViewModel(section: 0).dateString, dateString1)
        XCTAssertEqual(subject.headerViewModel(section: 1).dateString, dateString2)
        XCTAssertEqual(subject.numberOfRowsInSection(0), 1)
        XCTAssertEqual(subject.numberOfRowsInSection(1), 1)
        XCTAssertEqual(
            subject.cellViewModel(indexPath: IndexPath(row: 0, section: 0)).timeString,
            timeString
        )
        dateTimeFormatter.verify(.timeString(for: .any))
    }
    
}
