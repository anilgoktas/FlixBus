//
//  NetworkSession.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Combine

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
            return Just(error)
                .setSuccessType(to: JSON.self)
                .eraseToAnyPublisher()
        }
    }
    
    public func perform<Operation: NetworkOperation>(
        operation: Operation.Type,
        request: Operation.Request
    ) -> AnyPublisher<Operation.Response, Error> {
        perform(request: request)
            .tryMap(Operation.Response.init)
            .eraseToAnyPublisher()
    }
    
}
