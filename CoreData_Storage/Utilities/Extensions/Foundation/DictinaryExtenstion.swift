//
//  DictinaryExtenstion.swift
//  SmartVillage
//
//  Created by Ilesh's 2018 on 28/08/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
