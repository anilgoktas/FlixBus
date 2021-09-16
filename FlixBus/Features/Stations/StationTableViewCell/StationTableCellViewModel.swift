//
//  StationTableCellViewModel.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import Foundation

struct StationTableCellViewModel {
    
    // MARK: - Properties
    
    let name: String
    
    // MARK: - Life Cycle
    
    init(name: String) {
        self.name = name
    }
    
    init(station: Station) {
        name = station.name
    }
    
}
