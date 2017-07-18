//
//  ItemCoreDataExtension.swift
//  iWantThat
//
//  Created by Mac on 18/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        self.created = NSDate()
    }
}

