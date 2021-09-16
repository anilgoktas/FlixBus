//
//  StationTimetableRepository.swift
//  StationTimetableRepository
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

// sourcery: AutoMockable
protocol StationTimetableRepositoryProtocol {
    var arrivals: [StationTimetableElement] { get }
    var departures: [StationTimetableElement] { get }
    
    var onUpdate: (() -> Void)? { get set }
}

final class StationTimetableRepository: StationTimetableRepositoryProtocol {
    
    // MARK: - Properties
    
    // MARK: Public
    
    private(set) var arrivals: [StationTimetableElement] = []
    private(set) var departures: [StationTimetableElement] = []
    var onUpdate: (() -> Void)?
    
    // MARK: Private
    
    private let station: Station
    #warning("StationTimetableNetworkRouter")
    
    // MARK: - Life Cycle
    
    init(station: Station) {
        self.station = station
    }
    
}
