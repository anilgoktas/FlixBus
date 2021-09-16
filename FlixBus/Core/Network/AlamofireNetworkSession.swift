//
//  AlamofireNetworkSession.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Alamofire
import Combine

public final class AlamofireNetworkSession: NetworkSession {
    
    // MARK: - Properties

    public let session: Alamofire.Session
    private let authorizer: NetworkAuthorizing?
    
    // MARK: - Life Cycle
    
    public init(authorizer: NetworkAuthorizing?) {
        self.authorizer = authorizer
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.HTTPHeaders.default.dictionary
        
        // Configure session manager.
        let authorizerAdapter = authorizer.flatMap { AlamofireAuthorizer(authorizer: $0) }
        session = Alamofire.Session(configuration: configuration, interceptor: authorizerAdapter)
    }
    
    // MARK: - Session
    
    public func perform(urlRequest: URLRequest) -> AnyPublisher<JSON, Error> {
        session
            .request(urlRequest)
            .validate({ [weak self] request, urlResponse, data in
                do {
                    try self?.authorizer?.validate(request: request, urlResponse: urlResponse, data: data)
                    return .success
                } catch {
                    return .failure(error)
                }
            })
            .publishData()
            .tryMap { try $0.result.get() }
            .tryMap { try JSON(data: $0) }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Authorizer Adapter
    
    /// Private authorizer adaptor due to auto mock generation issues with Alamofire.
    private final class AlamofireAuthorizer: Alamofire.RequestInterceptor {
        
        private let authorizer: NetworkAuthorizing
        
        init(authorizer: NetworkAuthorizing) {
            self.authorizer = authorizer
        }
        
        func adapt(
            _ urlRequest: URLRequest,
            for session: Session,
            completion: @escaping (Result<URLRequest, Error>) -> Void
        ) {
            authorizer.adapt(urlRequest, completion: completion)
        }
        
        func retry(
            _ request: Request,
            for session: Session,
            dueTo error: Error,
            completion: @escaping (RetryResult) -> Void
        ) {
            authorizer.retry(request, dueTo: error, completion: completion)
        }
    }
    
}
