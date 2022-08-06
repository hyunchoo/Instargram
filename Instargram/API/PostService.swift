//
//  PostService.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/26.
//

import Foundation
import Firebase

struct PostService{
    
    /*
     param : caption
     param : image
     param : @escaping -> Void
     게시글을 올릴 때 쓰는 로직
     
     */
    static func uploadPost(caption: String, image: UIImage, user: User ,completion: @escaping(FirestoreCompletion)){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        DispatchQueue.global().async {
            ImageUploader.uploadImage(image: image) { imageUrl in
                let data = ["caption": caption,
                            "timestamp": Timestamp(date: Date()),
                            "likes": 0,
                            "imageUrl": imageUrl,
                            "ownerUid": uid,
                            "ownerImageUrl": user.profileImageUrl,
                            "ownerUsername": user.username] as [String : Any]
                
                let docRef = COLLECTION_POSTS.addDocument(data: data, completion: completion)
               
            }
        
        }
        
    }
    /*
     param : @escaping -> Void
     Feed에다가 post를 나타내기 위한 로직
     */
    static func fetchPosts(completion: @escaping([Post]) -> Void){
        DispatchQueue.global().async {
            COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                
                let posts = documents.map({Post(postId: $0.documentID, dictionary: $0.data())})
                DispatchQueue.main.async {
                    completion(posts)
                }
                
            }
        }
        
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void){
        
        DispatchQueue.global().async {
            let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
            
            query.getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                
                var posts = documents.map({Post(postId: $0.documentID, dictionary: $0.data())})
                
                posts.sort{(post1, post2) -> Bool in
                    return post1.timestamp.seconds > post2.timestamp.seconds }
                
                
                DispatchQueue.main.async {
                    completion(posts)
                }
                
            }
        }
        
        
    }
    
}
