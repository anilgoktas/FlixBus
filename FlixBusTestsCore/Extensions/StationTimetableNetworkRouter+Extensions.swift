//
//  StationTimetableNetworkRouter+Extensions.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus
import Combine

extension StationTimetableNetworkRouter {
    
    static func makeStubFetchPublisher(
        _ response: Fetch.Response = Fetch.Response(timetable: .makeEmpty())
    ) -> AnyPublisher<Fetch.Response, Error> {
        Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    static func makeStubFetchPublisher(
        error: Error
    ) -> AnyPublisher<Fetch.Response, Error> {
        Result<Fetch.Response, Error>.failure(error)
            .publisher
            .eraseToAnyPublisher()
    }
    
}
