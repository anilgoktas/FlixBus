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
    let dateTimeFormatter = DateTimeFormattingMock()
    
    func inject() {
        Current.date = Date.init
        Current.locale = .autoupdatingCurrent
        Current.logger = logger
        Current.network = network
        Current.dateTimeFormatting = dateTimeFormatter
    }
    
}

/// Syntactic Sugar for Mocker owner classes
protocol MockerOwner: AnyObject {
    var mocker: Mocker { get }
}

extension MockerOwner {
    
    var locale: Locale {
        get { Current.locale }
        set { Current.locale = newValue }
    }
    var logger: LoggingMock { mocker.logger }
    var network: NetworkSessionMock { mocker.network }
    var dateTimeFormatter: DateTimeFormattingMock { mocker.dateTimeFormatter }
    
}
