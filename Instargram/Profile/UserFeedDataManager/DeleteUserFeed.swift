//
//  DeleteUserFeed.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/08/06.
//

import Foundation

struct DeleteUserFeed: Decodable {
       let isSuccess: Bool
       let code: Int
       let message: String
       let result: String
}
