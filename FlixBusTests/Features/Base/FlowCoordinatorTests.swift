//
//  FlowCoordinatorTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/18/21.
//

import XCTest
@testable import FlixBus

final class FlowCoordinatorTests: BaseTestCase {
    
    // MARK: - Factory
    
    private func makeSubject() -> FlowCoordinator {
        FlowCoordinator()
    }
    
}

// MARK: - Tests

extension FlowCoordinatorTests {
    
    func test_init() {
        // Given & When
        let subject = makeSubject()
        
        // Then
        XCTAssertNil(subject.rootViewController)
        XCTAssertNil(subject.navigationController)
        XCTAssertNil(subject.stationsViewController)
    }
    
    func test_configure() throws {
        // Given
        let subject = makeSubject()
        
        // When
        subject.configure()
        
        // Then
        let stationsViewController = try XCTUnwrap(subject.stationsViewController)
        let navigationController = try XCTUnwrap(subject.navigationController)
        XCTAssertTrue(navigationController.viewControllers.first === stationsViewController)
        let rootViewController = try XCTUnwrap(subject.rootViewController)
        XCTAssertTrue(navigationController === rootViewController)
    }
    
    func test_stationsViewController_didSelectStation() throws {
        // Given
        let station = Station.berlinZOB
        let subject = makeSubject()
        subject.configure()
        let stationsViewController = try XCTUnwrap(subject.stationsViewController)
        let navigationController = try XCTUnwrap(subject.navigationController)
        
        // When
        stationsViewController.didSelectStation?(station)
        waitForMainQueueCycle()
        
        // Then
        let stationViewController = try XCTUnwrap(
            navigationController.viewControllers.last as? StationViewController
        )
        XCTAssertEqual(stationViewController.viewModel.title, station.name)
    }
    
}
