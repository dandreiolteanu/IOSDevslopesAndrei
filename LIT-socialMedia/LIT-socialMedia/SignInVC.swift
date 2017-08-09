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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailField.resignFirstResponder()
        self.passwordField.endEditing(true)
    }
    
    


    
    
    
    
    
    
    
    
    @IBAction func logInPressed(_ sender: Any) {
        
        if let email = self.emailField.text, let password = self.passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    print("FIREBASE: Email user authenticated with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            print("FIREBASE: Unable to authenticate with Firebase using email")
                            self.emailField.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.8)
                        } else {
                            print("FIREBASE: Successfully authenticated with Firebase")
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
                print("FACEBOOK \(error)")
            case .cancelled:
                print("FACEBOOK: User cancelled login.")
            case .success:
                print("FACEBOOK: Logged in!")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("FIREBASE: UNABLE TO CONNECT TO FIREBASE \(String(describing: error))")
            } else {
                print("FIREBASE: Logged in!")
            }
            
        }
    }

}


