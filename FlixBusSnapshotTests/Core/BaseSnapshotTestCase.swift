//
//  BaseSnapshotTestCase.swift
//  BaseSnapshotTestCase
//
//  Created by Anil Goktas on 9/13/21.
//

import XCTest
@testable import FlixBus
import FBSnapshotTestCase

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
    
    /// Proxy method for `FBSnapshotVerifyViewController`
    /// - Parameters: `file` and `line` parameters in order to show failure message on associated test
    func verify(_ viewController: UIViewController, file: StaticString = #file, line: UInt = #line) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.isHidden = false
        
        FBSnapshotVerifyViewController(viewController, file: file, line: line)
        // Wait for a main queue cycle in order to clear window from both UI and memory.
        waitForMainQueueCycle()
    }
    
    func verify<NavigationController: UINavigationController>(
        _ viewController: UIViewController,
        pushedInto: NavigationController.Type,
        hidesBackButton: Bool = false,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let navigationController = NavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(viewController, animated: false)
        viewController.navigationItem.hidesBackButton = hidesBackButton
        verify(navigationController, file: file, line: line)
    }
    
}
