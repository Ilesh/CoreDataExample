//
//  Categories+CoreDataProperties.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 13/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var category_name: String
    @NSManaged public var categoryTransactiontype: TransactionType

}
