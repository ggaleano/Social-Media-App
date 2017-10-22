//
//  PostCell.swift
//  Social Media
//
//  Created by Geovanny Galeano on 10/15/17.
//  Copyright © 2017 Geovanny Galeano. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: CircleView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postingImg: UIImageView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var likes: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
