//
//  DateTimeFormatting.swift
//  DateTimeFormatting
//
//  Created by Anil Goktas on 9/14/21.
//

import Foundation

// sourcery: AutoMockable
protocol DateTimeFormatting {
    func dateString(for dateTime: DateTime) -> String
    func timeString(for dateTime: DateTime) -> String
}

/// Caches date formatters based on their time zones since creating them is expensive.
/// - Note: [Resource](https://sarunw.com/posts/how-expensive-is-dateformatter/)
final class DateTimeFormatter: DateTimeFormatting {
    
    // MARK: - Properties
    
    private var dateStringFormatters = [TimeZone: DateFormatter]()
    private var timeStringFormatters = [TimeZone: DateFormatter]()
    
    // MARK: - Formatting
    
    func dateString(for dateTime: DateTime) -> String {
        if let formatter = dateStringFormatters[dateTime.timeZone] {
            return formatter.string(from: dateTime.date)
        } else {
            let formatter = makeDateStringFormatter(timeZone: dateTime.timeZone)
            dateStringFormatters[dateTime.timeZone] = formatter
            return formatter.string(from: dateTime.date)
        }
    }
    
    func timeString(for dateTime: DateTime) -> String {
        if let formatter = timeStringFormatters[dateTime.timeZone] {
            return formatter.string(from: dateTime.date)
        } else {
            let formatter = makeTimeStringFormatter(timeZone: dateTime.timeZone)
            timeStringFormatters[dateTime.timeZone] = formatter
            return formatter.string(from: dateTime.date)
        }
    }
    
    // MARK: - Caching
    
    private func makeDateStringFormatter(timeZone: TimeZone) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
    
    private func makeTimeStringFormatter(timeZone: TimeZone) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    
}
