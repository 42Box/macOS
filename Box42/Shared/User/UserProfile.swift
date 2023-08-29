//
//  UserProfile.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

struct UserProfile: Codable {
    let uuid: String
    let nickname: String
    let theme: Int
    let icon: String
    let urlList: [URLItem]
    let statusMessage: String
    let profileImageUrl: String
    let profileImagePath: String
}

struct URLItem: Codable {
    let name: String
    let url: String
}

extension UserProfile {
    static func defaultProfile() -> UserProfile {
        return UserProfile(
            uuid: "fox",
            nickname: "fox",
            theme: 0,
            icon: "fox",
            urlList: [URLItem(name: "home", url: "https://42box.kr/"),
                      URLItem(name: "23Coaltheme", url: "https://42box.github.io/front-end/"),
                      URLItem(name: "loopback", url: "http://127.0.0.1:3000/"),
                      URLItem(name: "Box 42", url: "https://42box.github.io/front-end/#/box"),
                      URLItem(name: "Intra 42", url: "https://intra.42.fr"),
                      URLItem(name: "Jiphyeonjeon", url: "https://42library.kr"),
                      URLItem(name: "42STAT", url: "https://stat.42seoul.kr/home"),
                      URLItem(name: "24Hane", url: "https://24hoursarenotenough.42seoul.kr"),
                      URLItem(name: "80kCoding", url: "https://80000coding.oopy.io"),
                      URLItem(name: "where42", url: "https://www.where42.kr"),
                      URLItem(name: "cabi", url: "https://cabi.42seoul.io/"),
                      URLItem(name: "42gg", url: "https://42gg.kr/")],
            statusMessage: "hello 42Box!",
            profileImageUrl: "https://42box.kr/user_profile_image/a52671f9-fca9-43ad-b0c0-1c5360831cf2.png",
            profileImagePath: "user_profile_image/a52671f9-fca9-43ad-b0c0-1c5360831cf2.png"
        )
    }
}
