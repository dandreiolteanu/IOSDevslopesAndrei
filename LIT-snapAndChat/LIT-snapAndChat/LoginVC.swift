//
//  LoginVC.swift
//  LIT-snapAndChat
//
//  Created by Olteanu Andrei on 16/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import TextFieldEffects

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!

    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var hideDetailsButton: UIButton!
    
    @IBOutlet weak var viewTopLogInBtnBottom: NSLayoutConstraint!
    @IBOutlet weak var logoConstraint: NSLayoutConstraint!
    @IBOutlet weak var textFieldConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textFieldConstraint.constant = -70
        
        UIView.animate(withDuration: 0.05) {
            self.hideDetailsButton.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textFieldConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5) {
            self.hideDetailsButton.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func showDetails(_ sender: Any) {
        
        
        self.detailsButton.alpha = 0.0
        
        self.viewTopLogInBtnBottom.constant = -self.view.frame.height + 210
        self.logoConstraint.constant = -18
        
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
                
            }, completion: nil)
    }
    @IBAction func hideDetails(_ sender: Any) {
        
        viewTopLogInBtnBottom.constant = -70
        logoConstraint.constant = 110
        
        passwordTextField.text = ""
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.detailsButton.alpha = 1.0
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text, (email.characters.count > 0 && password.characters.count > 0) {

            AuthService.instance.login(email: email, password: password, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Lit", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
