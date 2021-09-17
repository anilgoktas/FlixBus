//
//  StationsViewModel.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import Foundation

// sourcery: AutoMockable
protocol StationsViewModelProtocol {
    var numberOfRows: Int { get }
    
    func station(at index: Int) -> Station
    func cellViewModel(at index: Int) -> StationTableCellViewModel
}

final class StationsViewModel: StationsViewModelProtocol {
    
    // MARK: - Properties
    
    private let repository: StationsRepositoryProtocol
    
    // MARK: - Life Cycle
    
    init(repository: StationsRepositoryProtocol = StationsRepository()) {
        self.repository = repository
    }
    
    // MARK: - Model
    
    private var stations: [Station] { repository.stations }
    
    var numberOfRows: Int { stations.count }
    
    func station(at index: Int) -> Station { stations[index] }
    
    func cellViewModel(at index: Int) -> StationTableCellViewModel {
        let station = station(at: index)
        return StationTableCellViewModel(station: station)
    }
    
}
