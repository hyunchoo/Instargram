//
//  FeedUploadDataManager.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/22.
//

import Foundation
import Alamofire

class FeedUploadDataManager {
    func posts(_ viewController: HomeViewController, _ parameter: FeedUploadInput) {
        AF.request("https://edu-api-ios-test.softsquared.com/posts", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: FeedUploadModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSucess {
                    print("성공1")
                } else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
