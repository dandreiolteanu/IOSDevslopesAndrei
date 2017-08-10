//
//  SignInVC.swift
//  AndreiSocial
//
//  Created by Mac on 08/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordField: UITextFieldX!
    @IBOutlet weak var emailField: UITextFieldX!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var keyImage: UIImageView!
    
    // GRADIENT ANIMATION
    @IBOutlet weak var bgView: UIViewX!
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    var currentColorArrayIndex = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // COLORS FOR THE ANIMATION
        colorArray.append((color1: #colorLiteral(red: 0.2614560127, green: 0.5238626599, blue: 0.8510312438, alpha: 1) , color2: #colorLiteral(red: 0.1839679507, green: 0.4602154504, blue: 0.9190436169, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.1839679507, green: 0.4602154504, blue: 0.9190436169, alpha: 1) , color2: #colorLiteral(red: 0.6221295595, green: 0.2155836225, blue: 0.4734605551, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.6221295595, green: 0.2155836225, blue: 0.4734605551, alpha: 1) , color2: #colorLiteral(red: 0.5611749291, green: 0.2202819586, blue: 0.563821733, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5611749291, green: 0.2202819586, blue: 0.563821733, alpha: 1) , color2: #colorLiteral(red: 0.3987122774, green: 0.314450562, blue: 0.709374249, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3987122774, green: 0.314450562, blue: 0.709374249, alpha: 1) , color2: #colorLiteral(red: 0.2966733277, green: 0.4200778604, blue: 0.7318040729, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2966733277, green: 0.4200778604, blue: 0.7318040729, alpha: 1) , color2: #colorLiteral(red: 0.2784220278, green: 0.525316, blue: 0.8143386245, alpha: 1)))
        
        animateBgView()
        passwordField.delegate = self
        emailField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.passwordField.text = ""
        self.emailField.text = ""
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    
    func animateBgView() {
        currentColorArrayIndex = currentColorArrayIndex == (colorArray.count - 1) ? 0 : currentColorArrayIndex + 1
        // SETTING THE DURATION OF THE ANIMATION FROM HERE
        UIView.transition(with: bgView, duration: 3, options: [.transitionCrossDissolve], animations: {
            
            self.bgView.firstColor = self.colorArray[self.currentColorArrayIndex].color1
            self.bgView.secondColor = self.colorArray[self.currentColorArrayIndex].color2
            
        }) { (success) in
            self.animateBgView()
        }
    }
    //  TEXT FIELDS RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailField.resignFirstResponder()
        self.passwordField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.passwordField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.15)
        self.emailField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.15)
    }
    
    
    
    
    
    
    
    
    
    @IBAction func logInPressed(_ sender: Any) {
        
        if let email = self.emailField.text, let password = self.passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    print("ANDREI: FIREBASE: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            print("ANDREI: FIREBASE: Unable to authenticate with Firebase using email")
                            self.emailField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.8)
                            self.passwordField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.8)
                        } else {
                            print("ANDREI: FIREBASE: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print("ANDREI: FACEBOOK \(error)")
            case .cancelled:
                print("ANDREI: FACEBOOK: User cancelled login.")
            case .success:
                print("ANDREI: FACEBOOK: Logged in!")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("ANDREI: FIREBASE: UNABLE TO CONNECT TO FIREBASE \(String(describing: error))")
            } else {
                print("ANDREI: FIREBASE: Logged in!")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ANDREI: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }
    
}


