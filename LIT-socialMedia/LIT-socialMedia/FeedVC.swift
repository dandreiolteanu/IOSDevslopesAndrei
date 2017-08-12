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
import FirebaseDatabase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var charactersCounter: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postView: UIViewX!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var closePostBtn: UIButton!
    

    @IBOutlet weak var centerYPopupConstraint: NSLayoutConstraint!
    

    var popUpViewBlurred: UIViewX!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var imageAddShadow: ShadowRoundedUIView2!
    @IBOutlet weak var imageAddDelete: UIImageView!
    @IBOutlet weak var imageAdd: UIImageViewX!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        textView.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        textView.text = "Say something lit about your photo."
        textView.textColor = UIColor.lightGray
        
        popUpViewBlurred = UIViewX(frame: view.frame)
        self.view.insertSubview(popUpViewBlurred, belowSubview: postView)
        self.popUpViewBlurred.backgroundColor = UIColor.black
        self.popUpViewBlurred.alpha = 0.0
        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("ANDREI: FIREBASE: SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        print(post.imageUrl)
                    }
                }
            }
            self.tableView.reloadData()
        })
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
                        
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, image: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return PostCell()
        }
    }

    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ANDREI: ID Removed from KEYCHAIN \(keychainResult)")
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
 
    @IBAction func showPostPopup(_ sender: Any) {
        
        self.closePostBtn.isHidden = false
        self.postBtn.isHidden = true
        
        centerYPopupConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {

            self.popUpViewBlurred.alpha = 0.85
            self.view.layoutIfNeeded()

        }, completion: nil)
        
    }
    @IBAction func closePopUp(_ sender: Any) {
        
        self.closePostBtn.isHidden = true
        self.postBtn.isHidden = false
        
        centerYPopupConstraint.constant = 430
        UIView.animate(withDuration: 0.2) {
            
            self.view.layoutIfNeeded()
            self.popUpViewBlurred.alpha = 0.0
        }
        
        self.textView.text = "Say something lit about your photo."
        self.textView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        centerYPopupConstraint.constant = -70
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        if textView.textColor == UIColor.lightGray {
            self.textView.text = ""
            self.textView.textColor = UIColor.black
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let len = textView.text.characters.count
        self.charactersCounter.text = "\(len)/45 Characters"
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        centerYPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
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
        return numberOfChars < 46
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.isHidden = false
            imageAddDelete.isHidden = false
            imageAddShadow.isHidden = false
            imageAdd.image = image
            
        } else {
            print("ANDREI: a valid image wasn't selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func deletePostImagePressed(_ sender: Any) {
        self.imageAdd.isHidden = true
        self.imageAddDelete.isHidden = true
        imageAddShadow.isHidden = true
    }
}








