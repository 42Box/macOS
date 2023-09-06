//
//  URLModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

typealias nameUrl = (name: String, url: String)

struct URLModel {
    var id: UUID
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.id = UUID()
        self.name = name
        self.url = url
    }
}

struct URLModels {
    var info: [URLModel]
    
    // Network logic api call 날려서 받아올 것.
    let URLstring: [nameUrl] = [
        ("42Box", "https://42box.kr/"),
        ("23Coaltheme", "https://42box.github.io/front-end/"),
        ("Intra 42", "https://intra.42.fr"),
        ("Jiphyeonjeon", "https://42library.kr"),
        ("42STAT", "https://stat.42seoul.kr/home"),
        ("24Hane", "https://24hoursarenotenough.42seoul.kr"),
        ("80kCoding", "https://80000coding.oopy.io"),
        ("Where42", "https://www.where42.kr"),
        ("Cabi", "https://cabi.42seoul.io/"),
        ("42GG", "https://42gg.kr/"),
    ]
}
