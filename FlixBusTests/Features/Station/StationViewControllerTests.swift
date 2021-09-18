//
//  StationViewControllerTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationViewControllerTests: BaseTestCase {
    
    // MARK: - Properties
    
    private let viewModel = StationViewModelProtocolMock()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel.given(.title(getter: "Title"))
        viewModel.given(.scheduleType(getter: .arrivals))
        viewModel.given(.numberOfSections(getter: 0))
    }
    
    // MARK: - Factory
    
    private func makeSubject() -> StationViewController {
        let subject = StationViewController.instantiate(viewModel: viewModel)
        subject.loadViewIfNeeded()
        return subject
    }
    
}

// MARK: - Tests

extension StationViewControllerTests {
    
    func test_IBOutlets() {
        // Given & When
        let subject = makeSubject()
        
        // Then
        XCTAssertNotNil(subject.scheduleTypeSegmentedControl)
        XCTAssertEqual(
            subject.scheduleTypeSegmentedControl.numberOfSegments,
            StationViewModel.ScheduleType.allCases.count
        )
        XCTAssertNotNil(subject.tableView)
        XCTAssertTrue(subject.tableView.dataSource === subject)
        XCTAssertTrue(subject.tableView.delegate === subject)
    }
    
    func test_IBActions() throws {
        // Given
        let subject = makeSubject()
        
        // When & Then
        try subject.scheduleTypeSegmentedControl.validateAndPerform(.valueChanged)
    }
    
    func test_scheduleTypeSegmentedControl_initialValueShouldEqualToViewModel() {
        // Given
        let scheduleType = StationViewModel.ScheduleType.departures
        viewModel.given(.scheduleType(getter: scheduleType))
        
        // When
        let subject = makeSubject()
        
        // Then
        subject.scheduleTypeSegmentedControl.selectedSegmentIndex = scheduleType.rawValue
    }
    
    func test_scheduleTypeSegmentedControl_valueChanged() throws {
        // Given
        let subject = makeSubject()
        
        // When & Then
        let firstScheduleType = StationViewModel.ScheduleType.departures
        subject.scheduleTypeSegmentedControl.selectedSegmentIndex = firstScheduleType.rawValue
        try subject.scheduleTypeSegmentedControl.validateAndPerform(.valueChanged)
        viewModel.verify(.scheduleType(set: .value(firstScheduleType)))
        
        // When & Then
        let secondScheduleType = StationViewModel.ScheduleType.arrivals
        subject.scheduleTypeSegmentedControl.selectedSegmentIndex = secondScheduleType.rawValue
        try subject.scheduleTypeSegmentedControl.validateAndPerform(.valueChanged)
        viewModel.verify(.scheduleType(set: .value(secondScheduleType)))
    }
    
    func test_tableViewDataSource() throws {
        // Given
        let numberOfSections = 2
        viewModel.given(.numberOfSections(getter: numberOfSections))
        let numberOfRowsInSection = 2
        viewModel.given(.numberOfRowsInSection(.any, willReturn: numberOfRowsInSection))
        let cellViewModel = StationTimetableElementTableCellViewModel(
            timeString: "Time",
            lineAndDirectionString: "Line and direction",
            briefRouteString: "Brief Route"
        )
        viewModel.given(.cellViewModel(indexPath: .any, willReturn: cellViewModel))
        
        // When
        let subject = makeSubject()
        
        // Then
        let dataSource = try XCTUnwrap(subject.tableView.dataSource)
        XCTAssertEqual(
            dataSource.numberOfSections?(in: subject.tableView),
            numberOfSections
        )
        XCTAssertEqual(
            dataSource.tableView(subject.tableView, numberOfRowsInSection: 0),
            numberOfRowsInSection
        )
        let cell = try XCTUnwrap(
            dataSource.tableView(
                subject.tableView,
                cellForRowAt: IndexPath(row: 0, section: 0)
            ) as? StationTimetableElementTableViewCell
        )
        XCTAssertEqual(cell.viewModel?.timeString, cellViewModel.timeString)
        XCTAssertEqual(cell.viewModel?.lineAndDirectionString, cellViewModel.lineAndDirectionString)
        XCTAssertEqual(cell.viewModel?.briefRouteString, cellViewModel.briefRouteString)
    }
    
    func test_tableViewDelegate() throws {
        // Given
        let dateString = "Unit/Testing/Date"
        let headerViewModel = StationTimetableSectionHeaderViewModel(dateString: dateString)
        viewModel.given(.headerViewModel(section: .any, willReturn: headerViewModel))
        
        // When
        let subject = makeSubject()
        
        // Then
        let delegate = try XCTUnwrap(subject.tableView.delegate)
        XCTAssertNil(
            delegate.tableView?(subject.tableView, viewForFooterInSection: 0)
        )
        let headerView = try XCTUnwrap(
            delegate.tableView?(
                subject.tableView,
                viewForHeaderInSection: 0
            ) as? StationTimetableSectionHeaderView
        )
        XCTAssertEqual(headerView.viewModel?.dateString, dateString)
    }
    
    func test_viewDidLoad() {
        // Given & When
        let _ = makeSubject()
        
        // Then
        viewModel.verify(.title)
        viewModel.verify(.onUpdate(set: .any))
        viewModel.verify(.configureDataSource())
    }
    
}
