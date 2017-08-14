//
//  PostCell.swift
//  LIT-socialMedia
//
//  Created by Mac on 10/08/2017.
//  Copyright © 2017 Olteanu Andrei. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import FirebaseStorage
import FirebaseDatabase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var likesLbl: UILabel!

    @IBOutlet weak var spinner: NVActivityIndicatorView!
    
    @IBOutlet weak var lit1: UIButton!
    @IBOutlet weak var lit2: UIButton!
    @IBOutlet weak var lit3: UIButton!
    
    var post: Post!
    var likesRefFire1: DatabaseReference!
    var likesRefFire2: DatabaseReference!
    var likesRefFire3: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if downloadedImages == false {
            self.spinner.startAnimating()
        }
    }
    
    func configureCell(post: Post, image: UIImage? = nil) {
                
        self.post = post
        
        likesRefFire1 = DataService.ds.REF_USER_CURRENT.child("likes-fire1").child(post.postKey)
        likesRefFire2 = DataService.ds.REF_USER_CURRENT.child("likes-fire2").child(post.postKey)
        likesRefFire3 = DataService.ds.REF_USER_CURRENT.child("likes-fire3").child(post.postKey)
        
        self.caption.text = post.caption
        if post.likes > 1000 {
            self.likesLbl.text = "\(post.likes / 1000)K"
            self.likesLbl.text = self.likesLbl.text?.replacingOccurrences(of: ",", with: ".")
        } else {
            self.likesLbl.text = "\(post.likes)"

        }
        if image != nil {
            self.postImage.image = image
        } else {
            
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("ANDREI: Unable to download image from Firebase storage")
                } else {
                    print("ANDREI: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            
                            self.spinner.stopAnimating()
                            self.spinner.isHidden = true
                            
                        }
                    }
                }
            })
        }
        
        
        likesRefFire1.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                
                self.lit1.setImage(UIImage(named: "lit0"), for: .normal)
                
            } else {
                self.lit1.setImage(UIImage(named: "lit1"), for: .normal)
            }
        })
        
        likesRefFire2.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                
                self.lit2.setImage(UIImage(named: "lit0"), for: .normal)
                
            } else {
                self.lit2.setImage(UIImage(named: "lit2"), for: .normal)
            }
        })
        
        likesRefFire3.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                
                self.lit3.setImage(UIImage(named: "lit0"), for: .normal)
                
            } else {
                self.lit3.setImage(UIImage(named: "lit3"), for: .normal)
            }
        })
        
    }
    
    @IBAction func lit1Tapped(_ sender: Any) {
        
        likesRefFire1.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.lit1.setImage(UIImage(named: "lit1"), for: .normal)
                self.post.adjustLikes(numberOfLikes: 1, addLike: true)
                self.likesRefFire1.setValue(true)
                
            } else {
                self.lit1.setImage(UIImage(named: "lit0"), for: .normal)
                self.post.adjustLikes(numberOfLikes: 1, addLike: false)
                self.likesRefFire1.removeValue()
            }
        })
    }
    
    @IBAction func lit2Tapped(_ sender: Any) {
        
        likesRefFire2.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.lit2.setImage(UIImage(named: "lit2"), for: .normal)
                self.post.adjustLikes(numberOfLikes: 2, addLike: true)
                self.likesRefFire2.setValue(true)
                
            } else {
                self.lit2.setImage(UIImage(named: "lit0"), for: .normal)
                self.post.adjustLikes(numberOfLikes: 2, addLike: false)
                self.likesRefFire2.removeValue()
            }
        })

    }
    
    @IBAction func lit3Tapped(_ sender: Any) {
        
        likesRefFire3.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.lit3.setImage(UIImage(named: "lit3"), for: .normal)
                self.post.adjustLikes(numberOfLikes: 3, addLike: true)
                self.likesRefFire3.setValue(true)
                
            } else {
                self.lit3.setImage(UIImage(named: "lit0"), for: .normal)
                self.post.adjustLikes(numberOfLikes: 3, addLike: false)
                self.likesRefFire3.removeValue()
            }
        })

    }
}



