//
//  StationTableViewCellSnapshotTests.swift
//  FlixBusSnapshotTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationTableViewCellSnapshotTests: BaseSnapshotTestCase {
    
    // MARK: - Factory
    
    private func makeSubject(
        viewModel: StationTableCellViewModel?
    ) throws -> StationTableViewCell {
        let subject = try XCTUnwrap(
            R.nib.stationTableViewCell
                .firstView(owner: nil, options: nil)
        )
        subject.viewModel = viewModel
        subject.frame.size = subject
            .systemLayoutSizeFittingToScreenWidthAndCompressedHeight()
        return subject
    }
    
}

// MARK: - Tests

extension StationTableViewCellSnapshotTests {
    
    func test_placeholder() throws {
        // Given & When
        let subject = try makeSubject(viewModel: nil)
        
        // Then
        verify(subject)
    }
    
    func test_singleLine() throws {
        // Given
        let viewModel = StationTableCellViewModel(name: "Unit Testing Station")
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
    func test_multiLine() throws {
        // Given
        let viewModel = StationTableCellViewModel(
            name: "Unit Testing Station\nThis is second line\nThis is third"
        )
        
        // When
        let subject = try makeSubject(viewModel: viewModel)
        
        // Then
        verify(subject)
    }
    
}
