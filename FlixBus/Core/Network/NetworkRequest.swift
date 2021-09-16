//
//  NetworkRequest.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias JSONEncoding = Alamofire.JSONEncoding
public typealias URLEncoding = Alamofire.URLEncoding

public protocol NetworkRequest {
    var baseURL: URL { get }
    var relativePath: String? { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var parameterEncoding: NetworkParameterEncoding { get }
    var timeoutInterval: TimeInterval { get }
}

public extension NetworkRequest {
    
    var relativePath: String? { nil }
    
    var method: HTTPMethod { .get }
    
    var parameters: [String: Any]? { nil }
    
    var parameterEncoding: NetworkParameterEncoding { NetworkParameterEncoder.json }
    
    var timeoutInterval: TimeInterval { 30 }
    
    var url: URL {
        guard let relativePath = relativePath else { return baseURL }
        return baseURL.appendingPathComponent(relativePath)
    }
    
    func urlRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = timeoutInterval
        return try parameterEncoding.encode(urlRequest, with: parameters)
    }
    
}
