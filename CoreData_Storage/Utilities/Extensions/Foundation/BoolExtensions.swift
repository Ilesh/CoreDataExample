//
//
//
//  Created by Self on 11/16/17.
//  Copyright © 2017   All rights reserved.
//

import Foundation

// MARK: - Properties
public extension Bool {
    
    /// Return 1 if true, or 0 if false.
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    public var int: Int {
        return self ? 1 : 0
    }
    
    /// Return "true" if true, or "false" if false.
    ///
    ///        false.string -> "false"
    ///        true.string -> "true"
    ///
    public var string: String {
        return description
    }
    
    /// Return inversed value of bool.
    ///
    ///        false.toggled -> true
    ///        true.toggled -> false
    ///
    public var toggled: Bool {
        return !self
    }
    
    /// Returns a random boolean value.
    ///
    ///     Bool.random -> true
    ///     Bool.random -> false
    ///
    public static var random: Bool {
        return arc4random_uniform(2) == 1
    }
    
}

