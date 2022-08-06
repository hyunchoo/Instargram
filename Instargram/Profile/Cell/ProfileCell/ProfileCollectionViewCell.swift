//
//  ProfileCollectionViewCell.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/08.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addProfileImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var postingCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupAttribure()
    }
    
    private func setupAttribure() {
        profileImageView.layer.cornerRadius = 44
        addProfileImageView.layer.cornerRadius = 12
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor
        editButton.layer.borderWidth = 1
        
        
        addFriendButton.layer.cornerRadius = 3
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor
        addFriendButton.layer.borderWidth = 1
        
        [followerCountLabel, followingCountLabel, postingCountLabel].forEach {$0.text = "\(Int.random(in:0...100))" }
        
    }
    
    
}
