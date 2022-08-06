//
//  PostCollectionViewCell.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/19.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var postImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func setupData(imageURLStr: String?) {
        //이미지뷰의 이미지를 업로드 한다.
        guard let imageURLStr = imageURLStr else { return }
        if let url = URL(string: imageURLStr) {
            
            postImageVIew.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
    
}
