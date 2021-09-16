//
//  BaseSnapshotTestCase.swift
//  BaseSnapshotTestCase
//
//  Created by Anil Goktas on 9/13/21.
//

@testable import FlixBus
import FBSnapshotTestCase
import XCTest

class BaseSnapshotTestCase: FBSnapshotTestCase, MockerOwner {
    
    // MARK: - Properties
    
    let mocker = Mocker()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // `setUpWithError` is being called before `setUp`.
        // Therefore we're injecting mocker here in order to prevent overrides.
        mocker.inject()
    }
    
    override func setUp() {
        super.setUp()
        
        recordMode = false
        fileNameOptions = [.screenScale]
    }
    
    // MARK: - Helpers
    
    /// Proxy method for `FBSnapshotVerifyView`
    /// - Passing `file` and `line` parameters to show failure message on associated test
    func verify<T: UIView>(_ view: T, file: StaticString = #file, line: UInt = #line) {
        FBSnapshotVerifyView(view, file: file, line: line)
    }
    
}
