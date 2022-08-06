//
//  Picker.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/26.
//

import UIKit
import YPImagePicker

class PickerViewController: UIViewController {
 
    
    var user:User?
    var selectImage: UIImage?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.fetchUser()
        self.pickers()
        navigationItem.title = "Upload Post"
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        self.pickerYp()
//    }
//
//
//func didFinishPickingMedia(_ picker: YPImagePicker){
//    picker.didFinishPicking { items, _ in
//        picker.dismiss(animated: false) {
//            guard let selectedImage = items.singlePhoto?.image else {return}
//
//            let controller = UploadViewController()
////            controller.selectedImage = selectedImage
////            controller.delegate = self
////            controller.currentUser = self.user
//            let nav = UINavigationController(rootViewController: controller)
//
//            nav.modalPresentationStyle = .fullScreen
//            self.present(nav, animated: true, completion: nil)
//        }
//    }
//}
    
    func pickers() {
        let picker = YPImagePicker()
        picker.didFinishPicking { [self, unowned picker] items, _ in
            guard let selectImage =  items.singlePhoto?.image else {return}
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                guard let user = user else {
                    return
                }

                PostService.uploadPost(caption: "randon", image: selectImage, user: user) { error in
                    if let error = error{
                        return
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    func fetchUser(){
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func pickerYp() {
        var config = YPImagePickerConfiguration()
        
        config.library.mediaType = .photo
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 1
        
        
        let picker = YPImagePicker(configuration: config)
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
        
//        didFinishPickingMedia(picker)
    
    }
    
}

