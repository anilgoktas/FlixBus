//
//  StationsRepository.swift
//  StationsRepository
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

// sourcery: AutoMockable
protocol StationsRepositoryProtocol {
    var stations: [Station] { get }
}

final class StationsRepository: StationsRepositoryProtocol {
    
    let stations: [Station] = [
        Station(id: 1, name: "Berlin ZOB"),
        Station(id: 10, name: "Munich ZOB")
    ]
    
}
