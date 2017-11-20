//
//  PostCell.swift
//  Social Media
//
//  Created by Geovanny Galeano on 10/15/17.
//  Copyright © 2017 Geovanny Galeano. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: CircleView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postingImg: UIImageView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!

    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.postText.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postingImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("GEO: Unable to download image from Firebase storage")
                } else {
                    print("GEO: Image downloaded from Firebase storage" )
                    if let imgData = data {
                    if let img = UIImage(data: imgData) {
                        self.postingImg.image = img
                        FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
            }
        }
        
}

