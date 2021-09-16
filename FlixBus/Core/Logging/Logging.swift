//
//  Logging.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import os.log

extension OSLog {
    
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let network = OSLog(subsystem: subsystem, category: "Network")
    
}

// sourcery: AutoMockable
protocol Logging {
    func log(_ message: String, log: OSLog, type: OSLogType)
}

extension Logging {
    
    // MARK: UI
    
    func uiDefault(_ message: String) {
        self.log(message, log: .ui, type: .default)
    }
    
    func uiError(_ message: String) {
        self.log(message, log: .ui, type: .error)
    }
    
    // MARK: Network
    
    func networkDefault(_ message: String) {
        self.log(message, log: .network, type: .default)
    }
    
    func networkError(_ message: String) {
        self.log(message, log: .network, type: .error)
    }
    
}
