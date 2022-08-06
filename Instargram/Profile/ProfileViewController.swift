//
//  ProfileViewController.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/08.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var profileCollectionView: UICollectionView!

    var userPosts: [GetUserPosts]? {
        didSet { self.profileCollectionView.reloadData()}
    }
    
    var deletedIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setUpData()
    }

    //MARK: - Actions
    
    @objc func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        let position = gestureRecognizer.location(in: profileCollectionView)
        if let indexPath = profileCollectionView.indexPathForItem(at: position) {
            print("DEBUG: ", indexPath.item)
            
            //삭제 API 호출
            guard let userPosts = self.userPosts else { return }
            let cellData = userPosts[indexPath.item]
            self.deletedIndex = indexPath.item
            if let postIdx = cellData.postIdx {
                UserFeedDataManager().deleteUserFeed(self, postIdx)
            }
           
        }
    }
    
//MARK: - Helpers
    
   private func setupCollectionView() {
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
       let profileNib = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
       profileCollectionView.register(profileNib, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
       let postfileNib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
       profileCollectionView.register(postfileNib, forCellWithReuseIdentifier: "PostCollectionViewCell")
       
       let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell))
       gesture.minimumPressDuration = 0.66
       gesture.delegate = self
       gesture.delaysTouchesBegan = true
       profileCollectionView.addGestureRecognizer(gesture)
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("성공")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! UIViewController
                        vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("DEBUG : Failed to sign out")
        }
    
    }
    func setUpData() {
        UserFeedDataManager().getUserFeed(self)
       }
}

//MARK: - UICollectionViewDelegate - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //section의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // Cell의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return userPosts?.count ?? 0
            
        }
    }
    
    // Cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
            
            let itemIndex = indexPath.item
            
            if let cellData = self.userPosts {
                cell.setupData(imageURLStr: cellData[itemIndex].postImgUrl)// <------ 데이터 전달
            }
            
            return cell
            

        }
    }
}


extension ProfileViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: CGFloat(159))
        default:
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
            return CGSize(width: side, height: side)
        }
    }
    // 행간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    // 열간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}

//MARK: - API 통신 메소드
 
extension ProfileViewController {
    func successFeedAPI(_ result: UserFeedModel) {
        self.userPosts = result.result?.getUserPosts
    }
    func successDeletePostAPI(_ isSuccess: Bool) {
        guard isSuccess else { return }
        if let deletedIndex = self.deletedIndex {
            self.userPosts?.remove(at: deletedIndex)
        }
    }
}
