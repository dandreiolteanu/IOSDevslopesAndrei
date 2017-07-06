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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func uptadeUI(logangs: Logangs) {
        videoTitle.text = logangs.videoTitle
        //TODO: set image from url
        
        
    }
}
