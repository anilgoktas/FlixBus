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
    var onUpdate: (() -> Void)? { get set }
    func configureDataSource()
    
    var numberOfSections: Int { get }
    func headerViewModel(section: Int) -> StationTimetableSectionHeaderViewModel
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellViewModel(indexPath: IndexPath) -> StationTimetableElementTableCellViewModel
}

final class StationViewModel: StationViewModelProtocol {
    
    // MARK: - Properties
    
    var scheduleType: ScheduleType = .arrivals { didSet { updateDataSource() } }
    var onUpdate: (() -> Void)?
    
    private let repository: StationTimetableRepositoryProtocol
    private var dateStrings = [String]()
    private var dateElementsCache = [String: [StationTimetableElement]]()
    
    // MARK: Computed
    
    var title: String { station.name }
    private var station: Station { repository.station }
    
    // MARK: Injected
    
    private var dateTimeFormatter: DateTimeFormatting { Current.dateTimeFormatter }
    
    // MARK: - Life Cycle
    
    init(repository: StationTimetableRepositoryProtocol) {
        self.repository = repository
    }
    
}

// MARK: - Table Data Source

extension StationViewModel {
    
    private var scheduleElements: [StationTimetableElement] {
        switch scheduleType {
        case .arrivals: return repository.arrivals
        case .departures: return repository.departures
        }
    }
    
    func configureDataSource() {
        repository.configure { [weak self] in
            self?.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        // Reset caches.
        dateStrings.removeAll()
        dateElementsCache.removeAll()
        
        // Configure caches.
        for element in scheduleElements {
            autoreleasepool {
                let dateString = dateTimeFormatter.dateString(for: element.dateTime)
                if let elements = dateElementsCache[dateString] {
                    let updatedElements = elements + [element]
                    dateElementsCache[dateString] = updatedElements
                } else {
                    dateStrings.append(dateString)
                    dateElementsCache[dateString] = [element]
                }
            }
        }
        
        onUpdate?()
    }
    
    var numberOfSections: Int { dateStrings.count }
    
    func headerViewModel(section: Int) -> StationTimetableSectionHeaderViewModel {
        let dateString = dateStrings[section]
        return .init(dateString: dateString)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let dateString = dateStrings[section]
        if let elements = dateElementsCache[dateString] {
            return elements.count
        } else {
            return 0
        }
    }
    
    func cellViewModel(indexPath: IndexPath) -> StationTimetableElementTableCellViewModel {
        let dateString = dateStrings[indexPath.section]
        guard let elements = dateElementsCache[dateString] else {
            fatalError("No element available on the given date.")
        }
        let element = elements[indexPath.row]
        return .init(element: element)
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
