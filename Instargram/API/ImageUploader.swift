//
//  ImageUploader.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/26.
//

import FirebaseStorage
import UIKit
 
struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/ImagePhoto/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error{
                print("DEBEG : Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL{ (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
            
        }
        
    }
    
    
    
}


