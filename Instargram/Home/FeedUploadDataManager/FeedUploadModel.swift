//
//  FeedUploadModel.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/22.
//

import Foundation


struct FeedUploadModel : Decodable {
    var isSucess : Bool
    var code : Int
    var message: String
    var result : FeedUploadResult?
}


struct FeedUploadResult :Decodable {
    var postIdx : Int?
}
