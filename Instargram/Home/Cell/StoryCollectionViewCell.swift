//
//  StoryCollectionViewCell.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/07.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewBackground: UIView!
    
    @IBOutlet weak var userProfileBackground: UIView!
    
    @IBOutlet weak var imageViewuserProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewBackground.layer.cornerRadius = 24
        userProfileBackground.layer.cornerRadius = 23.5
        imageViewuserProfile.layer.cornerRadius = 22.5
        imageViewuserProfile.clipsToBounds = true
        
    }

}
