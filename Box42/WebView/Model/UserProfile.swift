//
//  UserProfile.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

struct UserProfile: Codable {
    let theme: Int
    let uuid: String
    let icon: String
    let nickname: String
    let profileImageUrl: String
    let urlList: [URLItem]
    let profileImagePath: String
    let statusMessage: String
}

struct URLItem: Codable {
    let name: String
    let url: String
}
