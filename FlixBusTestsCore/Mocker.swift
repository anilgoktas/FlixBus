//
//  Mocker.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

@testable import FlixBus
import Foundation

final class Mocker {
    
    // MARK: - Properties
    
    let logger = LoggingMock()
    let network = NetworkSessionMock()
    
    func inject() {
        Current.date = Date.init
        Current.logger = logger
        Current.network = network
    }
    
}

/// Syntactic Sugar for Mocker owner classes
protocol MockerOwner: AnyObject {
    var mocker: Mocker { get }
}

extension MockerOwner {
    
    var logger: LoggingMock { mocker.logger }
    var network: NetworkSessionMock { mocker.network }
    
}
