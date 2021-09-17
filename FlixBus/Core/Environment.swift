//
//  Environment.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

struct Environment {
    
    // MARK: - Stored Properties
    
    var date: () -> Date = Date.init
    var locale: Locale = .autoupdatingCurrent
    var flowCoordinator: FlowCoordinating = FlowCoordinator()
    var dateTimeFormatter: DateTimeFormatting = DateTimeFormatter()
    var logger: Logging = Logger()
    var network: NetworkSession = AlamofireNetworkSession(authorizer: NetworkAuthorizer.authorized)
    
    // MARK: - Computed Properties
    
    var isUnitTesting: Bool { ProcessInfo.processInfo.arguments.contains("-UNITTEST") }
    
}

var Current = Environment() {
    didSet {
        if !Current.isUnitTesting {
            fatalError("Only test targets can modify the current environment")
        }
    }
}
