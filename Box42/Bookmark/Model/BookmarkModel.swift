//
//  BookmarkModel.swift
//  Box42
//
//  Created by Chan on 2023/09/04.
//

struct URLList: Codable {
    let urlList: [URLItem]
}

struct URLItem: Codable {
    var name: String
    let url: String
}

extension URLItem: Equatable {
    static func ==(lhs: URLItem, rhs: URLItem) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
