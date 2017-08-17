//
//  AuthService.swift
//  LIT-snapAndChat
//
//  Created by Mac on 17/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode == .userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            
                            } else {
                            
                                if user?.uid != nil {
                                    DataService.instance.saveUser(uid: user!.uid)
                                    //Sign In
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                    
                                        if error != nil {
                                        
                                            //Show error to user
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        
                                        } else {
                                        
                                            //Successfully logged in
                                            onComplete?(nil,user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    //Handle all other errors
                    self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                }
            } else {
                //Successfully logged in
                onComplete?(nil,user)
            }
        }
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch (errorCode) {
            case .invalidEmail:
                onComplete?("Invalid Email address", nil)
                break
            case .wrongPassword:
                onComplete?("Invalid Password", nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?("Could not create account.Email already in use",nil)
                break
            default:
                onComplete?("There was a problem autheticating", nil)
                
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
