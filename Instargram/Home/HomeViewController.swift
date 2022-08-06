//
//  HomeViewController.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/05.
//

import UIKit
import Kingfisher
import Firebase

class HomeViewController: UIViewController {

    var arrayPhoto: [FeedModel] = []
    let imagePickerViewController = UIImagePickerController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        
        let input = FeedAPIInput(limit: 10, page: 0)
        FeedDataManager().feedDataManager(input, self)
//        imagePickerViewController.delegate = self
//        logout()
    }
    
    @IBAction func albumButton(_ sender: Any) {
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
//    
//    func logout(){
//        do{
//            try Auth.auth().signOut()
//        }catch{
//            print("DEBUG : Failed to sign out")
//        }
//    }
//    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPhoto.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else {return UITableViewCell()}
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
            if let urlString = arrayPhoto[indexPath.row - 1 ].url {
                let url = URL(string: urlString)
                cell.feedImageView.kf.setImage(with: url)
            }
           
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
            
        }else {
            return 600
        }
        
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else {return}
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
    
}

extension HomeViewController {
    func sucessAPI(_ result: [FeedModel]) {
        arrayPhoto = result
        tableView.reloadData()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           let imageString = "gs://instar-12709.appspot.com/ImagePhoto/B90728E1-EF9D-4939-B6E9-9C67A78EC672"
            let input = FeedUploadInput(content: "고양이에요", postImgUrl: [imageString])
            FeedUploadDataManager().posts(self, input)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
