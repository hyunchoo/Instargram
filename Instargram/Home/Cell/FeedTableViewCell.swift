//
//  FeedTableViewCell.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/06.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVIewUserProfile: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var myProfileImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        [imageVIewUserProfile,myProfileImageView].forEach {
            $0?.layer.cornerRadius = 9
            $0?.clipsToBounds = true
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonHeart(_ sender: UIButton) {
        if heartButton.isSelected {
            heartButton.isSelected = false
        } else {
            heartButton.isSelected = true
        }
    }
    @IBAction func buttonBookmark(_ sender: Any) {
        
    }
}
