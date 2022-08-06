//
//  UserFeedDatamanager.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/08/01.
//

import Foundation
import Alamofire

class UserFeedDataManager {
    func getUserFeed(_ viewController : ProfileViewController,_ userID : Int = 2  ) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)", method: .get, parameters: nil)
            .validate()
            .responseDecodable(of: UserFeedModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("성공: -----------------------------------\(result)")
                    viewController.successFeedAPI(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func deleteUserFeed(_ viewController : ProfileViewController,_ postIdx : Int  ) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/posts/\(postIdx)/status", method: .patch, parameters: nil)
            .validate()
            .responseDecodable(of: DeleteUserFeed.self) { response in
                switch response.result {
                case .success(let result):
                    viewController.successDeletePostAPI(result.isSuccess ?? false)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
