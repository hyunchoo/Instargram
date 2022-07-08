//
//  ProfileViewController.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/08.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
       
    }


   private func setupCollectionView() {
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
