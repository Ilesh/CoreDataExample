//
//  SubCategory+CoreDataProperties.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 13/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//
//

import Foundation
import CoreData


extension SubCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubCategory> {
        return NSFetchRequest<SubCategory>(entityName: "SubCategory")
    }

    @NSManaged public var name: String

}
