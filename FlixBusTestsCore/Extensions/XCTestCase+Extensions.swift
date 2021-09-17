//
//  XCTestCase+Extensions.swift
//  FlixBusSnapshotTests
//
//  Created by Anil Goktas on 9/17/21.
//

import XCTest

extension XCTestCase {
    
    /// Waits for a main queue style.
    func waitForMainQueueCycle() {
        let cycleExpectation = expectation(description: "Main queue cycle expectation")
        DispatchQueue.main.async { cycleExpectation.fulfill() }
        wait(for: [cycleExpectation], timeout: 10.0)
    }
    
}
