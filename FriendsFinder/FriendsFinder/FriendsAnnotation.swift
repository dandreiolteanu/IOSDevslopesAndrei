//
//  FriendsAnnotation.swift
//  FriendsFinder
//
//  Created by Mac on 26/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import MapKit

var friends = ["michael",
               "paul",
               "tasha",
               "deni",
               "kanye",
               "jingxhao",
               "davis",
               "tania"]


class FriendsAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var friendsName: String
    var friendsNumber: Int
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, friendsNumber: Int) {
        
        self.coordinate = coordinate
        self.friendsNumber = friendsNumber
        self.friendsName = friends[friendsNumber - 1].capitalized
        self.title = self.friendsName
    }
}
