//
//  LogangCellTableViewCell.swift
//  LogangVlogs
//
//  Created by Mac on 06/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class LogangCell: UITableViewCell {

    @IBOutlet weak var videoPreviewImage: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func uptadeUI(logangs: Logangs) {
        
//        videoPreviewImage.loadGif(name: "loading2")
        videoTitle.text = logangs.videoTitle
        //TODO: set image from url
        
        let url = URL(string: logangs.imageURL)!
        loading.startAnimating()
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.sync {
                    self.videoPreviewImage.image = UIImage(data: data)
                    self.loading.stopAnimating()
                }
            } catch {
                //handle the error
            }
            
        }
        
    }
}
