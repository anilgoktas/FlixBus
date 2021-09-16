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
        Future<Fetch.Response, Error> { promise in
            promise(.success(response))
        }.eraseToAnyPublisher()
    }
    
    static func makeStubFetchPublisher(
        error: Error
    ) -> AnyPublisher<Fetch.Response, Error> {
        Future<Fetch.Response, Error> { promise in
            promise(.failure(error))
        }.eraseToAnyPublisher()
    }
    
}
