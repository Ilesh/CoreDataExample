//
//  Transactions+CoreDataProperties.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var date: NSDate
    @NSManaged public var note: String?
    @NSManaged public var amount: Double
    @NSManaged public var categorys: Categories
    @NSManaged public var transactiontypes: TransactionType

}
