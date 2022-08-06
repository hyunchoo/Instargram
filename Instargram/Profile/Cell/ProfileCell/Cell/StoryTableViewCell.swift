//
//  StoryTableViewCell.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/07.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row : Int) {
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate
        collectionView.tag = row
        let storysNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(storysNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        //세로로 내려가던걸 가로로 변경하기 위해 사용
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 12
        
        collectionView.collectionViewLayout = flowLayout
        
        
        collectionView.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
