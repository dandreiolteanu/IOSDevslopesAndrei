//
//  User.swift
//  LIT-snapAndChat
//
//  Created by Mac on 17/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

struct User {
    
    private var _firstName: String
    private var _uid: String
    
    var uid: String{
        return _uid
    }
    
    var firstName: String{
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
    
    
}
