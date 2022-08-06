//
//  UserService.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/26.
//

import Foundation
import Firebase


struct UserService{
    /*
     param : @escaping -> Void
     현재 유저를 보여주는 로직
     */
    static func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        DispatchQueue.global().async {
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                guard let dictionary = snapshot?.data() else {return}
                let user = User(dictionary: dictionary)
                
                DispatchQueue.main.async {
                    completion(user)
                }
                
                
            }
        }
       
    }
    
    /*
     parma : @escaping
     모든 등록되 있는 유저를 받아온다.
     */
    static func fetchUsers(completion: @escaping([User]) -> Void){
        
        DispatchQueue.global().async {
            COLLECTION_USERS.getDocuments { snapshot, error in
                
                guard let snapshot = snapshot else {return}
                
                let users = snapshot.documents.map({User(dictionary: $0.data())})
                
                
                DispatchQueue.main.async {
                    completion(users)
                }
                
                
            }
        }
        
    }
    /*
     param : uid
     param : @escaping -> Void
     자신의 데이터가 맞는지 확인한다.
     */
    static func fetchUser(withUid uid: String,completion: @escaping(User) -> Void){
        DispatchQueue.global().async {
            COLLECTION_USERS.document(uid).getDocument{ snapshot, error in
                guard let dictionary = snapshot?.data() else {return}
                let user = User(dictionary: dictionary)
                DispatchQueue.main.async {
                    completion(user)
                }
                
            }
        }
        
        
    }
    /*
     param : uid
     param : @escaping -> void
     상대를 follow를 하기 위한 로직
     */
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        DispatchQueue.global().async {
            COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]){error in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
            }
        }
//        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]){error in
//            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
//        }
    }
    /*
     param : uid
     param : @escaping -> Void
     팔로우를 취소
     */
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        DispatchQueue.global().async {
            COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
            }
        }
//        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
//            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
//        }
    }
    /*
     param : uid
     param : @escaping -> Void
     상대를 팔로우를 체크하였는지 확인하는 로직
     */
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        DispatchQueue.global().async {
            COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
                guard let isFollowed = snapshot?.exists else{return}
                DispatchQueue.main.async {
                    completion(isFollowed)
                }
                
        }
            
            
        }
        
    }
    
    /*
     param : uid
     param : @escaping -> Void
     나를 팔로잉한 아이디, 내가 팔로우한 아이디, 내가 쓴 글의 카운팅
     */
//    static func fetchUserState(uid: String, completion: @escaping(UserStats) -> Void){
//
//        DispatchQueue.global().async {
//
//
//            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
//                let followers = snapshot?.documents.count ?? 0
//
//                COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
//                    let following = snapshot?.documents.count ?? 0
//
//                    COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { (snapshot, _) in
//                        let posts = snapshot?.documents.count ?? 0
//                        DispatchQueue.main.async {
//                            completion(UserStats(followers: followers, following: following, posts: posts))
//                        }
//
//                    }
//                }
//                //                    completion(UserStats(followers: followers, following: following, posts: posts))
//
//            }
//        }
//    }
    
    
    
    
}
