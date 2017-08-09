//
//  FeedVC.swift
//  LIT-socialMedia
//
//  Created by Mac on 09/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ANDREI: ID Removed from KEYCHAIN \(keychainResult)")
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
   
}
