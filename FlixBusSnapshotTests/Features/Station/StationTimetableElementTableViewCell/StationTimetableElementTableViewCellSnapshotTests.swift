//
//  StationTimetableElementTableViewCellSnapshotTests.swift
//  FlixBusSnapshotTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationTimetableElementTableViewCellSnapshotTests: BaseSnapshotTestCase {
    typealias ViewModel = StationTimetableElementTableCellViewModel
    
    // MARK: - Factory
    
    private func makeSubject(
        viewModel: StationTimetableElementTableCellViewModel?
    ) throws -> StationTimetableElementTableViewCell {
        let subject = try XCTUnwrap(
            R.nib.stationTimetableElementTableViewCell
                .firstView(owner: nil, options: nil)
        )
        subject.viewModel = viewModel
        subject.frame.size = subject
            .systemLayoutSizeFittingToScreenWidthAndCompressedHeight()
        return subject
    }
    
}

// MARK: - Tests

extension StationTimetableElementTableViewCellSnapshotTests {
    
    func test_placeholder() throws {
        // Given & When
        let subject = try makeSubject(viewModel: nil)
        
        // Then
        verify(subject)
    }
    
    func test_singleLine_all() throws {
        // Given
        let viewModel = ViewModel(
            timeString: "15:00",
            lineAndDirectionString: "Route 050 direction Hamburg ZOB",
            briefRouteString: "Berlin ZOB → Hamburg ZOB"
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
    func test_multiLine_timeString() throws {
        // Given
        let viewModel = ViewModel(
            timeString: "3:00\na.m.",
            lineAndDirectionString: "Route 050 direction Hamburg ZOB",
            briefRouteString: "Berlin ZOB → Hamburg ZOB"
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
    func test_multiLine_lineAndDirection() throws {
        // Given
        let viewModel = ViewModel(
            timeString: "15:00",
            lineAndDirectionString: "Route 050 direction Hamburg ZOB\nSecond Line\nThird Line",
            briefRouteString: "Berlin ZOB → Hamburg ZOB"
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
    func test_multiLine_briefRoute() throws {
        // Given
        let viewModel = ViewModel(
            timeString: "15:00",
            lineAndDirectionString: "Route 050 direction Hamburg ZOB",
            briefRouteString: "Berlin ZOB → Hamburg ZOB\nSecond Line\nThird Line"
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
    func test_multiLine_all() throws {
        let multiLineString = "\nSecond Line\nThird Line"
        // Given
        let viewModel = ViewModel(
            timeString: "3:00\na.m.",
            lineAndDirectionString: "Route 050 direction Hamburg ZOB" + multiLineString,
            briefRouteString: "Berlin ZOB → Hamburg ZOB" + multiLineString
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
}
