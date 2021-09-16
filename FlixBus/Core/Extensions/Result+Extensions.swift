//
//  Result+Extensions.swift
//  Result+Extensions
//
//  Created by Anil Goktas on 9/13/21.
//

import Foundation

extension Result where Success == Void {
    
    /// Convenience static property for `.success(())`
    public static var `success`: Result<Success, Failure> {
        .success(())
    }
    
}
