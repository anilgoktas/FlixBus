//
//  Station.swift
//  Station
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

struct Station: Identifiable {
    
    // MARK: - Properties
    
    let id: Int
    let name: String
    
    // MARK: - Life Cycle
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(json: JSON) {
        id = json[CodingKeys.id.rawValue].intValue
        name = json[CodingKeys.name.rawValue].stringValue
    }
    
}

// MARK: - CodingKeys

extension Station {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
}
