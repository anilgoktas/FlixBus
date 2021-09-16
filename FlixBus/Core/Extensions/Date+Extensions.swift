//
//  Date+Extensions.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import Foundation

extension Date {
    
    static func make(
        year: Int,
        month: Int,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil
    ) -> Date {
        var components = DateComponents()
        components.timeZone = TimeZone.current
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)!
    }
    
}
