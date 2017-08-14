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
import FirebaseStorage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // FEED VC
    @IBOutlet weak var charactersCounter: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postView: UIViewX!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var closePostBtn: UIButton!
    
    // POST VIEW, the view sliding from down
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
            
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
//                    print("ANDREI: FIREBASE: SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
//                        print(post.imageUrl)
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
            }
            return cell
        } else {
            return PostCell()
        }
    }

    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ANDREI: ID Removed from KEYCHAIN \(keychainResult)")
        try! Auth.auth().signOut()
        downloadedImages = true
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        
        if newText.isEmpty {
            textView.text = "Say something lit about your photo."
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            return false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
        return numberOfChars < 46
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.endEditing(true)
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
    @IBAction func postButtonPressed(_ sender: Any) {
        
        guard let caption = textView.text, caption != "" && caption != "Say something lit about your photo." else {
            print("ANDREI: Caption must be entered")
            return
        }
        
        guard let image = imageAdd.image, imageAdd.isHidden == false else {
            print("ANDREI: A valid image was not selected")
            return
        }
        
        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
            
            let imageUid = NSUUID().uuidString
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imageUid).putData(imageData, metadata: metadata, completion: { (metadata, error) in
                
                if error != nil {
                    print("ANDREI: Unable to upload image to firebase storage")
                } else {
                    print("ANDREI: Succesfully uploaded image to Firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    self.postToFirebase(imageUrl: downloadURL!)
                }
            })
            
        }
    }
    
    func postToFirebase(imageUrl: String) {
        
        let post: Dictionary<String, AnyObject> = [
            "caption": textView.text as AnyObject,
            "image": imageUrl as String as AnyObject,
            "likes": 0 as AnyObject
        ]
        // HERE IS THE POST ID
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        textView.text = ""
        imageAddShadow.isHidden = true
        imageAdd.isHidden = true
        imageAddDelete.isHidden = true
        closePopUp((Any).self)
        
        tableView.reloadData()
    }
}








