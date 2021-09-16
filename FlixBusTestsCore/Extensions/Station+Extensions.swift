//
//  Station+Extensions.swift
//  FlixBusTests
//
//  Created by Anil Goktas on 9/16/21.
//

import XCTest
@testable import FlixBus

extension Station {
    
    static var berlinZOB: Station {
        Station(id: 1, name: "Berlin ZOB")
    }
    
    static var munichZOB: Station {
        Station(id: 10, name: "Munich ZOB")
    }
    
}
