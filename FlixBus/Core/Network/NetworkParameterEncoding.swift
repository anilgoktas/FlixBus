//
//  NetworkParameterEncoding.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Alamofire

// sourcery: AutoMockable
public protocol NetworkParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest
}

public enum NetworkParameterEncoder: NetworkParameterEncoding {
    case url
    case json
    
    public func encode(_ urlRequest: URLRequest, with parameters: [String : Any]?) throws -> URLRequest {
        switch self {
        case .url: return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        case .json: return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
