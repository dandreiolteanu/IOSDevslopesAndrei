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

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var likesLbl: UILabel!

    @IBOutlet weak var spinner: NVActivityIndicatorView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.spinner.startAnimating()
    }
    
    func configureCell(post: Post, image: UIImage? = nil) {
                
        self.post = post
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
    }
}



