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

    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.signOutBtn.isHidden = false
//        self.postBtn.isHidden = false
    }

    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ANDREI: ID Removed from KEYCHAIN \(keychainResult)")
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.signOutBtn.isHidden = true
//        self.postBtn.isHidden = true
    }
    
}
