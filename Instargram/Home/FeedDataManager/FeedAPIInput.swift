//
//  FeedAPIInput.swift
//  Instargram
//
//  Created by 🙈 🙊 on 2022/07/20.
//

import Foundation

struct FeedAPIInput : Encodable {
    var limit: Int
    var page: Int
}

