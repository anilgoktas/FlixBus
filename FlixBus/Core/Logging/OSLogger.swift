//
//  OSLogger.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation
import os.log

final class OSLogger: Logging {
    
    func log(_ message: String, log: OSLog, type: OSLogType) {
        #if DEBUG || STAGING
        os_log("%{public}@", log: log, type: type, message)
        #else
        os_log("%{private}@", log: log, type: type, message)
        #endif
    }
    
}
