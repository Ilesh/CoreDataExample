//
//  Extensions.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import Foundation

extension NSDate {
    var display : String {
        let date = self as Date
        return date.dateTimeString(withFormate: "dd MMM yyyy")
    }
}
