//
//  NetworkOperation.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

public protocol NetworkOperation {
    associatedtype Request: NetworkRequest
    associatedtype Response: NetworkResponse
}
