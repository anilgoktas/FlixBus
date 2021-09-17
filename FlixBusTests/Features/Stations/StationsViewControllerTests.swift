//
//  StationsViewControllerTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationsViewControllerTests: BaseTestCase {
    
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

extension StationsViewControllerTests {
    
    func test_IBOutlets() {
        // Given & When
        let subject = makeSubject()
        
        // Then
        XCTAssertNotNil(subject.tableView)
        XCTAssertTrue(subject.tableView.dataSource === subject)
        XCTAssertTrue(subject.tableView.delegate === subject)
    }
    
    func test_tableViewDataSource() throws {
        // Given
        let numberOfRows = 1
        viewModel.given(.numberOfRows(getter: numberOfRows))
        let cellViewModel = StationTableCellViewModel(name: "Unit Testing")
        viewModel.given(.cellViewModel(at: .any, willReturn: cellViewModel))
        
        // When
        let subject = makeSubject()
        
        // Then
        XCTAssertEqual(
            numberOfRows,
            subject.tableView(subject.tableView, numberOfRowsInSection: 0)
        )
        let cell = try XCTUnwrap(
            subject.tableView.dataSource?.tableView(
                subject.tableView,
                cellForRowAt: IndexPath(row: 0, section: 0)
            ) as? StationTableViewCell
        )
        XCTAssertEqual(cellViewModel.name, cell.viewModel?.name)
    }
    
    func test_didSelectStation() throws {
        // Given
        let station = Station.berlinZOB
        viewModel.given(.numberOfRows(getter: 1))
        viewModel.given(.cellViewModel(at: .any, willReturn: .init(station: station)))
        viewModel.given(.station(at: .any, willReturn: station))
        let subject = makeSubject()
        
        var didSelectStation: Station?
        subject.didSelectStation = { station in
            didSelectStation = station
        }
        
        // When
        subject.tableView.delegate?.tableView?(
            subject.tableView,
            didSelectRowAt: IndexPath(row: 0, section: 0)
        )
        
        // Then
        let selectedStation = try XCTUnwrap(didSelectStation)
        XCTAssertEqual(station.id, selectedStation.id)
    }
    
}
