//
//  NetworkSession.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Combine
import SwiftyJSON

// sourcery: AutoMockable
public protocol NetworkSession {
    func perform(urlRequest: URLRequest) -> AnyPublisher<JSON, Error>
}

extension NetworkSession {
    
    public func perform(request: NetworkRequest) -> AnyPublisher<JSON, Error> {
        do {
            let urlRequest = try request.urlRequest()
            return perform(urlRequest: urlRequest)
        } catch {
            return Future<JSON, Error> { promise in
                promise(.failure(error))
            }.eraseToAnyPublisher()
        }
    }
    
    public func perform<Operation: NetworkOperation>(
        _ operation: Operation.Type,
        request: Operation.Request
    ) -> AnyPublisher<Operation.Response, Error> {
        perform(request: request)
            .tryMap(Operation.Response.init)
            .eraseToAnyPublisher()
    }
    
}
