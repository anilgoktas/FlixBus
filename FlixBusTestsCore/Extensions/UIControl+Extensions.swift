//
//  UIControl+Extensions.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import UIKit
import XCTest

extension UIControl {
    
    /// Validates that given control events has actions.
    func validateAction(
        _ controlEvens: UIControl.Event,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        XCTAssertFalse(
            allTargets.isEmpty,
            "UIControl must have a target",
            file: file,
            line: line
        )
        XCTAssertFalse(
            allControlEvents.isEmpty,
            "UIControl must have a control event",
            file: file,
            line: line
        )
        XCTAssertTrue(
            allControlEvents.contains(controlEvens),
            "UIControl must have the given control events",
            file: file,
            line: line
        )
    }
    
    /// Validates that given control events has actions and sends all actions.
    func validateAndPerform(
        _ controlEvents: UIControl.Event,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        try validateAction(controlEvents, file: file, line: line)
        sendActions(for: controlEvents)
    }
    
}
