//
//  StationTimetableRepository.swift
//  StationTimetableRepository
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import Combine

// sourcery: AutoMockable
protocol StationTimetableRepositoryProtocol {
    var station: Station { get }
    var arrivals: [StationTimetableElement] { get }
    var departures: [StationTimetableElement] { get }
    
    func configure(_ completion: @escaping () -> Void)
}

final class StationTimetableRepository: StationTimetableRepositoryProtocol {
    typealias Element = StationTimetableElement
    
    // MARK: - Properties
    
    // MARK: Public
    
    // MARK: Computed
    
    let station: Station
    var arrivals: [StationTimetableElement] { timetable.arrivals }
    var departures: [StationTimetableElement] { timetable.departures }
    
    // MARK: Private
    
    private let networkRouter: StationTimetableNetworkRouting
    
    private var timetable: StationTimetable = .makeEmpty()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    
    init(
        station: Station,
        networkRouter: StationTimetableNetworkRouting = StationTimetableNetworkRouter()
    ) {
        self.station = station
        self.networkRouter = networkRouter
    }
    
    func configure(_ completion: @escaping () -> Void) {
        networkRouter
            .fetchTimetable(stationID: station.id)
            .replaceError(with: .init(timetable: .makeEmpty()))
            .sink { [weak self] response in
                self?.configure(response: response)
                completion()
            }.store(in: &subscriptions)
    }
    
    private func configure(response: StationTimetableNetworkRouter.Fetch.Response) {
        let sortedArrivals = response.timetable.arrivals.sorted(by: {
            $0.dateTime.date.timeIntervalSince1970 < $1.dateTime.date.timeIntervalSince1970
        })
        let sortedDepartures = response.timetable.departures.sorted(by: {
            $0.dateTime.date.timeIntervalSince1970 < $1.dateTime.date.timeIntervalSince1970
        })
        timetable = StationTimetable(arrivals: sortedArrivals, departures: sortedDepartures)
    }
    
}
