//
//  URLModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

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
    
    // Network logic
    let URLstring: [(String, String)] = [
        ("home", "https://42box.github.io/front-end/"),
        //        ("home", "http://127.0.0.1:3000/"),
        ("Box 42", "https://42box.github.io/front-end/#/box"),
        ("Intra 42", "https://intra.42.fr"),
        ("Jiphyeonjeon", "https://42library.kr"),
        ("E-Library", "https://42seoul.dkyobobook.co.kr/main.ink"),
        ("24Hane", "https://24hoursarenotenough.42seoul.kr"),
        ("80000Coding", "https://80000coding.oopy.io"),
        ("where42", "https://www.where42.kr"),
        ("cabi", "https://cabi.42seoul.io/"),
        ("42gg", "https://42gg.kr/"),
        ("textart", "https://textart.sh/")
    ]
    
    mutating func urlSetup() {
        URLstring.forEach { (name, url) in
            info.append(URLModel(name: name, url: url))
        }
    }
}
