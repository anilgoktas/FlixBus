//
//  StationTimetableSectionHeaderViewSnapshotTests.swift
//  FlixBusSnapshotTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest
@testable import FlixBus

final class StationTimetableSectionHeaderViewSnapshotTests: BaseSnapshotTestCase {
    
    // MARK: - Factory
    
    private func makeSubject(
        viewModel: StationTimetableSectionHeaderViewModel?
    ) throws -> StationTimetableSectionHeaderView {
        let subject = try XCTUnwrap(
            R.nib.stationTimetableSectionHeaderView.firstView(owner: nil, options: nil)
        )
        subject.viewModel = viewModel
        subject.frame.size = subject
            .systemLayoutSizeFittingToScreenWidthAndCompressedHeight()
        return subject
    }
    
}

// MARK: - Tests

extension StationTimetableSectionHeaderViewSnapshotTests {
    
    func test_placeholder() throws {
        // Given & When
        let subject = try makeSubject(viewModel: nil)
        
        // Then
        verify(subject)
    }
    
    func test_singleLine() throws {
        // Given
        let viewModel = StationTimetableSectionHeaderViewModel(dateString: "Unit/Testing/Date")
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
    func test_multiLine() throws {
        // Given
        let viewModel = StationTimetableSectionHeaderViewModel(
            dateString: "Unit/Testing/Date\nThis is second line\nThis is third"
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
}
