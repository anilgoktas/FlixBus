//
//  StationViewModel.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import Foundation

// sourcery: AutoMockable
protocol StationViewModelProtocol {
    var title: String { get }
    var scheduleType: StationViewModel.ScheduleType { get set }
    
    var numberOfSections: Int { get }
    func headerViewModel(section: Int) -> StationTimetableSectionHeaderViewModel
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellViewModel(indexPath: IndexPath) -> StationTimetableElementTableCellViewModel
}

final class StationViewModel: StationViewModelProtocol {
    
    // MARK: - Properties
    
    var scheduleType: ScheduleType = .arrivals { didSet { configureDataSource() } }
    
    private let repository: StationTimetableRepositoryProtocol
    
    // MARK: Computed
    
    var title: String { station.name }
    private var station: Station { repository.station }
    
    // MARK: - Life Cycle
    
    init(repository: StationTimetableRepositoryProtocol) {
        self.repository = repository
    }
    
}

// MARK: - Table Data Source

extension StationViewModel {
    
    private func configureDataSource() {
        /*
         - Check possible dates, format and use that string as a key
         - Use strings as headers and its elements as table cells
         */
    }
    
    var numberOfSections: Int { 2 }
    
    func headerViewModel(section: Int) -> StationTimetableSectionHeaderViewModel {
        .init(dateString: "Example Date \(section)")
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        0
    }
    
    func cellViewModel(indexPath: IndexPath) -> StationTimetableElementTableCellViewModel {
        fatalError("Complete")
    }
    
}

// MARK: - ScheduleType

extension StationViewModel {
    
    enum ScheduleType: Int, CaseIterable {
        case arrivals
        case departures
        
        var title: String {
            switch self {
            case .arrivals: return "Arrivals"
            case .departures: return "Departures"
            }
        }
    }
    
}
