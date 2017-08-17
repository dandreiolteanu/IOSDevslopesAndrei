//
//  DataService.swift
//  LIT-snapAndChat
//
//  Created by Mac on 17/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var MAIN_REF: DatabaseReference {
        return Database.database().reference()
    }
    
    var USERS_REF: DatabaseReference {
        return MAIN_REF.child(FIR_CHILD_USERS)
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject,
                                                      "lastName": "" as AnyObject,
                                                      "username": "" as AnyObject
                                                    ]
        MAIN_REF.child(FIR_CHILD_USERS).child(uid).child(FIR_USERS_CHILD_PROFILE).setValue(profile)
    }
}
