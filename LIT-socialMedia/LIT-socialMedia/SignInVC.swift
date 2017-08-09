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

class SignInVC: UIViewController {

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
    
    @IBAction func facebookBtnPressed(_ sender: Any) {

        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success:
                print("Logged in!")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("UNABLE TO CONNECT TO FIREBASE \(error)")
            } else {
                print("LOGGED IN!")
            }
            
        }
    }


}

