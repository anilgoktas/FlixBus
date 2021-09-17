//
//  StationTimetableElementTableCellViewModel.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import Foundation

struct StationTimetableElementTableCellViewModel {
    
    // MARK: - Properties
    
    let timeString: String
    let lineAndDirectionString: String
    let briefRouteString: String
    
    // MARK: - Life Cycle
    
    init(timeString: String,
         lineAndDirectionString: String,
         briefRouteString: String
    ) {
        self.timeString = timeString
        self.lineAndDirectionString = lineAndDirectionString
        self.briefRouteString = briefRouteString
    }
    
    init(element: StationTimetableElement) {
        timeString = Current.dateTimeFormatter.timeString(for: element.dateTime)
        lineAndDirectionString = element.lineAndDirection
        briefRouteString = element.briefRoute
    }
    
}
