//
//  PostVC.swift
//  LIT-socialMedia
//
//  Created by Olteanu Andrei on 09/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit

class PostVC: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var charactersCounter: UILabel!
    @IBOutlet weak var postView: UIViewX!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.text = "Say something lit about your photo."
        textView.textColor = UIColor.lightGray
    }

  
    @IBAction func exitPostBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        movePostView(postView, moveDistance: -70, up: true)
        if textView.textColor == UIColor.lightGray {
            self.textView.text = ""
            self.textView.textColor = UIColor.black
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.postView.translatesAutoresizingMaskIntoConstraints = true
        let len = textView.text.characters.count
        self.charactersCounter.text = "\(len)/45 Characters"
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        movePostView(postView, moveDistance: -70, up: false)
        if textView.text == "" {
            textView.text = "Say something lit about your photo."
            textView.textColor = UIColor.lightGray
            self.charactersCounter.text = "0/45 Characters"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 45
    }
    
    func movePostView(_ view: UIViewX, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIViewX.beginAnimations("animatePostView", context: nil)
        UIViewX.setAnimationBeginsFromCurrentState(true)
        UIViewX.setAnimationDuration(moveDuration)
        self.postView.frame = self.postView.frame.offsetBy(dx: 0, dy: movement)
        UIViewX.commitAnimations()
    }
    
}
