//
//  NetworkAuthorizing.swift
//  NetworkAuthorizing
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Alamofire

// sourcery: AutoMockable
public protocol NetworkRequestAdapter {
    func adapt(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    )
}

// sourcery: AutoMockable
public protocol NetworkRetryableRequest {
    var retryCount: Int { get }
    var statusCode: Int? { get }
}

extension Alamofire.Request: NetworkRetryableRequest {
    public var statusCode: Int? {
        guard let urlResponse = task?.response as? HTTPURLResponse else { return nil }
        return urlResponse.statusCode
    }
}

// sourcery: AutoMockable
public protocol NetworkRequestRetrier {
    typealias RetryResult = Alamofire.RetryResult
    
    func retry(
        _ request: NetworkRetryableRequest,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    )
}

// sourcery: AutoMockable
public protocol NetworkInterceptor: NetworkRequestAdapter, NetworkRequestRetrier { }

// sourcery: AutoMockable
public protocol NetworkResponseValidating {
    func validate(
        request: URLRequest?,
        urlResponse: HTTPURLResponse,
        data: Data?
    ) throws
}

// MARK: - NetworkAuthorizing

// sourcery: AutoMockable
public protocol NetworkAuthorizing: NetworkInterceptor, NetworkResponseValidating { }

public final class NetworkAuthorizer: NetworkAuthorizing {
    
    private let adapter: NetworkRequestAdapter?
    private let retrier: NetworkRequestRetrier?
    private let responseValidator: NetworkResponseValidating?
    
    init(
        adapter: NetworkRequestAdapter?,
        retrier: NetworkRequestRetrier?,
        responseValidator: NetworkResponseValidating?
    ) {
        self.adapter = adapter
        self.retrier = retrier
        self.responseValidator = responseValidator
    }
    
    public func adapt(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard let adapter = adapter else {
            completion(.success(urlRequest))
            return
        }
        adapter.adapt(urlRequest, completion: completion)
    }
    
    public func retry(
        _ request: NetworkRetryableRequest,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let retrier = retrier else {
            completion(.doNotRetry)
            return
        }
        
        retrier.retry(request, dueTo: error, completion: completion)
    }
    
    public func validate(request: URLRequest?, urlResponse: HTTPURLResponse, data: Data?) throws {
        try responseValidator?.validate(request: request, urlResponse: urlResponse, data: data)
    }
    
}

// MARK: - Authorized

extension NetworkAuthorizer {
    
    static let authorized = NetworkAuthorizer(
        adapter: AuthorizedHeaderAdapter(),
        retrier: nil,
        responseValidator: nil
    )
    
}

// MARK: - Header Adapter

extension NetworkAuthorizer {
    
    final class AuthorizedHeaderAdapter: NetworkRequestAdapter {
        
        func adapt(
            _ urlRequest: URLRequest,
            completion: @escaping (Result<URLRequest, Error>) -> Void
        ) {
            var urlRequest = urlRequest
            urlRequest.setValue(
                Config.Endpoint.AuthenticationHeader.value,
                forHTTPHeaderField: Config.Endpoint.AuthenticationHeader.fieldName
            )
            completion(.success(urlRequest))
        }
        
    }
    
}
