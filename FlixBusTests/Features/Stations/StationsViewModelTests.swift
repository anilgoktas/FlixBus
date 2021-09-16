//
//  StationsViewModelTests.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

final class StationsViewModelTests: BaseTestCase {
    
    // MARK: - Properties
    
    private let repository = StationsRepositoryProtocolMock()
    
    // MARK: - Factory
    
    private func makeSubject() -> StationsViewModel {
        StationsViewModel(repository: repository)
    }
    
}

// MARK: - Tests

extension StationsViewModelTests {
    
    func test_numberOfRows() {
        // Given
        let subject = makeSubject()
        
        // When & Then
        let stations: [Station] = [.berlinZOB, .munichZOB]
        repository.given(.stations(getter: stations))
        XCTAssertEqual(subject.numberOfRows, stations.count)
        
        // When & Then
        repository.given(.stations(getter: [.berlinZOB]))
        XCTAssertEqual(subject.numberOfRows, 1)
    }
    
    func test_cellViewModel() throws {
        // Given
        let subject = makeSubject()
        let stations: [Station] = [.berlinZOB, .munichZOB]
        repository.given(.stations(getter: stations))
        
        // When
        let firstCellViewModel = subject.cellViewModel(at: 0)
        let secondCellViewModel = subject.cellViewModel(at: 1)
        
        // Then
        XCTAssertEqual(firstCellViewModel.name, stations.first?.name)
        XCTAssertEqual(secondCellViewModel.name, stations.last?.name)
    }
    
}
