//
//  NetworkResponse.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

public protocol NetworkResponse {
    init(json: JSON) throws
}
