//
//  BundleExtensions.swift
//  FoodPonDriver
//
//  Created by macmini on 13/03/19.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
