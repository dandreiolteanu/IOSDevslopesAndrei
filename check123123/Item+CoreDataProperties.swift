//
//  Item+CoreDataProperties.swift
//  check123123
//
//  Created by Mac on 17/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var title: String?

}
