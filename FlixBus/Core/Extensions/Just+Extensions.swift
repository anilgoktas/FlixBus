//
//  Just+Extensions.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/27/21.
//

import Foundation
import Combine

extension Just {

    func setSuccessType<Success>(
        to successType: Success.Type
    ) -> Result<Success, Output>.Publisher where Output: Error {
        .init(output)
    }

}
