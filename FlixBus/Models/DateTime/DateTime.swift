//
//  DateTime.swift
//  DateTime
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

struct DateTime {
    
    // MARK: - Properties
    
    let date: Date
    let timeZone: TimeZone
    
    // MARK: - Life Cycle
    
    init(timestamp: Int, timeZone: TimeZone) {
        self.date = Date(timeIntervalSince1970: Double(timestamp))
        self.timeZone = timeZone
    }
    
    init?(timestamp: Int, timeZoneAbbreviation: String) {
        guard let timeZone = TimeZone(abbreviation: timeZoneAbbreviation) else {
            return nil
        }
        self.init(timestamp: timestamp, timeZone: timeZone)
    }
    
    init?(json: JSON) {
        let timestamp = json[CodingKeys.date.rawValue].intValue
        let timeZoneAbbreviation = json[CodingKeys.timeZoneAbbreviation.rawValue].stringValue
        self.init(timestamp: timestamp, timeZoneAbbreviation: timeZoneAbbreviation)
    }
    
    var dictionaryValue: [String: Any] {
        var dict = [String: Any]()
        dict[CodingKeys.date.rawValue] = date.timeIntervalSince1970
        dict[CodingKeys.timeZoneAbbreviation.rawValue] = timeZone.abbreviation()
        return dict
    }
    
}

// MARK: - CodingKeys

extension DateTime {
    
    enum CodingKeys: String, CodingKey {
        case date = "timestamp"
        case timeZoneAbbreviation = "tz"
    }
    
}
