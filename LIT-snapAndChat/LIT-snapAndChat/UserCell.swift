//
//  UserCell.swift
//  LIT-snapAndChat
//
//  Created by Mac on 17/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl: UILabel!
    
    @IBOutlet weak var accessoryViewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setCheckmark(selected: false)
        
        selectionStyle = .none
    }

    func updateUI(user: User) {
        firstNameLbl.text = user.firstName
        
    }
    
//    func setCheckmark(selected: Bool) {
//        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
//        self.accessoryViewImage = UIImageView(image: UIImage(named: imageStr))
//    }

}
