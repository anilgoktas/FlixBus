//
//  StationTimetableNetworkRouter.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import Foundation
import Combine

// sourcery: AutoMockable
protocol StationTimetableNetworkRouting {
    typealias Fetch = StationTimetableNetworkRouter.Fetch
    
    func fetchTimetable(stationID: Station.ID) -> AnyPublisher<Fetch.Response, Error>
}

final class StationTimetableNetworkRouter: StationTimetableNetworkRouting {
    
    // MARK: - Properties
    
    // MARK: Injected
    
    private var network: NetworkSession { Current.network }
    
}

// MARK: - Fetch

extension StationTimetableNetworkRouter {
    
    enum Fetch: NetworkOperation {
        struct Request: NetworkRequest {
            let stationID: Station.ID
            
            var baseURL: URL { Config.Endpoint.url }
            var relativePath: String? { "mobile/v1/network/station/\(stationID)/timetable.json " }
            var method: HTTPMethod { .get }
            var parameterEncoding: NetworkParameterEncoding { NetworkParameterEncoder.url }
        }
        struct Response: NetworkResponse {
            let timetable: StationTimetable
            
            init(timetable: StationTimetable) {
                self.timetable = timetable
            }
            init(json: JSON) {
                timetable = StationTimetable(json: json["timetable"])
            }
        }
    }
    
    func fetchTimetable(stationID: Station.ID) -> AnyPublisher<Fetch.Response, Error> {
        network.perform(operation: Fetch.self, request: .init(stationID: stationID))
    }
    
}
