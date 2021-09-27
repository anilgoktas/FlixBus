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
        _ response: Fetch.Response = .init(timetable: .makeEmpty())
    ) -> AnyPublisher<Fetch.Response, Error> {
        Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    static func makeStubFetchPublisher(
        error: Error
    ) -> AnyPublisher<Fetch.Response, Error> {
        Just(error)
            .setSuccessType(to: Fetch.Response.self)
            .eraseToAnyPublisher()
    }
    
}
