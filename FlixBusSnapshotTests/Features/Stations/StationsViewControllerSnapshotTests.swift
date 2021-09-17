//
//  StationsViewControllerSnapshotTests.swift
//  FlixBusSnapshotTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationsViewControllerSnapshotTests: BaseSnapshotTestCase {
    
    // MARK: - Properties
    
    private let viewModel = StationsViewModelProtocolMock()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel.given(.numberOfRows(getter: 0))
    }
    
    // MARK: - Factory
    
    private func makeSubject() -> StationsViewController {
        let subject = StationsViewController.instantiate(viewModel: viewModel)
        subject.loadViewIfNeeded()
        return subject
    }
    
}

// MARK: - Tests

extension StationsViewControllerSnapshotTests {
    
    func test_empty() {
        // Given
        let subject = makeSubject()
        
        // When
        let baseNavigationController = BaseNavigationController(rootViewController: subject)
        
        // Then
        verify(baseNavigationController)
    }
    
    func test_withStations() {
        // Given
        let stations: [Station] = [.berlinZOB, .munichZOB]
        viewModel.given(.numberOfRows(getter: stations.count))
        for (index, station) in stations.enumerated() {
            let cellViewModel = StationTableCellViewModel(station: station)
            viewModel.given(
                .cellViewModel(at: .value(index), willReturn: cellViewModel)
            )
        }
        let subject = makeSubject()
        
        // When
        let baseNavigationController = BaseNavigationController(rootViewController: subject)
        
        // Then
        verify(baseNavigationController)
    }
    
}
