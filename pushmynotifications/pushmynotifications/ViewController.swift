//
//  ViewController.swift
//  pushmynotifications
//
//  Created by Mac on 24/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Messaging.messaging().subscribe(toTopic: "/topic/news")
        
        
    }

}

