//
//  Config.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

enum Config {
    
    /// API
    enum Endpoint {
        #if DEBUG
        static let urlString = "https://global.api-dev.flixbus.com"
        #elseif STAGING
        static let urlString = "https://global.api-dev.flixbus.com"
        #else
        static let urlString = "https://global.api-dev.flixbus.com"
        #endif
        static let url = URL(string: urlString)!
        
        enum AuthenticationHeader {
            static let fieldName = "X-Api-Authentication"
            static let value = "intervIEW_TOK3n"
        }
    }
    
    enum ThirdParty {
        
    }
    
}
