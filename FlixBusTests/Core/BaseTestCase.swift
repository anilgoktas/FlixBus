//
//  BaseTestCase.swift
//  BaseTestCase
//
//  Created by Anil Goktas on 9/13/21.
//

@testable import FlixBus
import XCTest

class BaseTestCase: XCTestCase, MockerOwner {
    
    // MARK: - Properties
    
    let mocker = Mocker()
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // `setUpWithError` is being called before `setUp`.
        // Therefore we're injecting mocker here in order to prevent overrides.
        mocker.inject()
    }
    
}
