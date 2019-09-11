//
//  TransactionType+CoreDataProperties.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionType> {
        return NSFetchRequest<TransactionType>(entityName: "TransactionType")
    }

    @NSManaged public var name: String

}
