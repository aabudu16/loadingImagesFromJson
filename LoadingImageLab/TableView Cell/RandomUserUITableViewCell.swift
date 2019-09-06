//
//  RandomUserUITableViewCell.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class RandomUserUITableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userPhoneNumber: UILabel!
    @IBOutlet var userAge: UILabel!
    @IBOutlet var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
