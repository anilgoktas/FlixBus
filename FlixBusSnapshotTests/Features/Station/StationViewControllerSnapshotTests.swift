//
//  StationViewControllerSnapshotTests.swift
//  FlixBusSnapshotTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationViewControllerSnapshotTests: BaseSnapshotTestCase {
    
    // MARK: - Properties
    
    private let viewModel = StationViewModelProtocolMock()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel.given(.title(getter: "Title"))
        viewModel.given(.scheduleType(getter: .arrivals))
        viewModel.given(.numberOfSections(getter: 0))
        dateTimeFormatter.given(.timeString(for: .any, willReturn: "15:00"))
    }
    
    // MARK: - Factory
    
    private func makeSubject() -> StationViewController {
        let subject = StationViewController.instantiate(viewModel: viewModel)
        subject.loadViewIfNeeded()
        return subject
    }
    
    // MARK: - Verify
    
    private func verify(
        subject: StationViewController,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        verify(
            subject,
            pushedInto: BaseNavigationController.self,
            file: file,
            line: line
        )
    }
    
}

// MARK: - Tests

extension StationViewControllerSnapshotTests {
    
    func test_initial() {
        // Given & When
        let subject = makeSubject()
        
        // Then
        verify(subject: subject)
    }
    
    func test_scheduleTypeSegmentedControl_departures() {
        // Given
        let scheduleType = StationViewModel.ScheduleType.departures
        viewModel.given(.scheduleType(getter: scheduleType))
        
        // When
        let subject = makeSubject()
        
        // Then
        verify(subject: subject)
    }
    
}

// MARK: - Table View Tests

extension StationViewControllerSnapshotTests {
    
    private struct Section {
        let index: Int
        let elements: [StationTimetableElement]
        var dateString: String { "Section \(index)" }
    }
    
    func test_tableView_singleSection() throws {
        // Given
        let dateTime = try DateTime.makeStub()
        let elements = [
            StationTimetableElement.makeExample1(dateTime: dateTime),
            StationTimetableElement.makeExample2(dateTime: dateTime),
            StationTimetableElement.makeExample3(dateTime: dateTime)
        ]
        let section = Section(index: 0, elements: elements)
        
        viewModel.given(.numberOfSections(getter: 1))
        viewModel.given(
            .headerViewModel(
                section: .value(section.index),
                willReturn: .init(dateString: section.dateString)
            )
        )
        viewModel.given(.numberOfRowsInSection(.any, willReturn: elements.count))
        for (index, element) in elements.enumerated() {
            let cellViewModel = StationTimetableElementTableCellViewModel(element: element)
            viewModel.given(
                .cellViewModel(
                    indexPath: .value(IndexPath(row: index, section: section.index)),
                    willReturn: cellViewModel
                )
            )
        }
        
        // When
        let subject = makeSubject()
        
        // Then
        verify(subject: subject)
    }
    
    func test_tableView_multipleSections() throws {
        // Given
        viewModel.given(.scheduleType(getter: .departures))
        
        let dateTime = try DateTime.makeStub()
        let element1 = StationTimetableElement.makeExample1(dateTime: dateTime)
        let element2 = StationTimetableElement.makeExample2(dateTime: dateTime)
        
        let sections: [Section] = [
            .init(index: 0, elements: [element1, element2]),
            .init(index: 1, elements: [element1]),
            .init(index: 2, elements: [element2]),
        ]
        viewModel.given(.numberOfSections(getter: sections.count))
        for section in sections {
            // Header
            viewModel.given(
                .headerViewModel(
                    section: .value(section.index),
                    willReturn: .init(dateString: section.dateString)
                )
            )
            // Number of cells
            viewModel.given(
                .numberOfRowsInSection(
                    .value(section.index),
                    willReturn: section.elements.count
                )
            )
            // Cells
            for (elementIndex, element) in section.elements.enumerated() {
                let cellViewModel = StationTimetableElementTableCellViewModel(element: element)
                viewModel.given(
                    .cellViewModel(
                        indexPath: .value(IndexPath(row: elementIndex, section: section.index)),
                        willReturn: cellViewModel
                    )
                )
            }
        }
        
        // When
        let subject = makeSubject()
        
        // Then
        verify(subject: subject)
    }
    
}
