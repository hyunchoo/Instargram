//
//  AuthService.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/26.
//

import UIKit
import Firebase
import FirebaseAuth

typealias FirestoreCompletion = (Error?) -> Void

struct AuthCredentials{
    let email:String
    let password:String
    let fullname:String
    let username:String
    
}
struct AuthService{
    /*
     param : AuthCredentials
     param : @escaping -> Void
     회원 등록
     */
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void){
//        DispatchQueue.global().async {
//            ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) {
                    (result, error) in
                 
                    if let error = error {
                        print("DEBUG: Failed to register user \(error.localizedDescription)")
                        completion(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let data: [String: Any] = ["email":credentials.email,
                                               "fullname":credentials.fullname,
                                               "uid": uid,
                                               "username":credentials.username]//키 밸류 저장
                    DispatchQueue.main.async {
                        Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                    }
                    
                    
                    
                }
            }
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        }
    }
        
    
