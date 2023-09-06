//
//  UserProfile.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import AppKit

struct UserProfile: Codable {
    let uuid: String
    let nickname: String
    let theme: Int
    let icon: String
    let urlList: [URLItem]
    let statusMessage: String
    let profileImageUrl: String
    let profileImagePath: String
    let quickSlotList: [QuickSlotButtonModel]
}

extension UserProfile {
    static func defaultProfile() -> UserProfile {
        return UserProfile(
            uuid: "fox",
            nickname: "fox",
            theme: 0,
            icon: "fox",
            urlList: BookmarkViewModel.shared.bookMarkList,
            statusMessage: "hello 42Box!",
            profileImageUrl: "https://42box.kr/user_profile_image/a52671f9-fca9-43ad-b0c0-1c5360831cf2.png",
            profileImagePath: "user_profile_image/a52671f9-fca9-43ad-b0c0-1c5360831cf2.png",
            quickSlotList: [ QuickSlotButtonModel(scriptUuid: UUID(uuidString: "37a56076-e72c-4efe-ba7f-de0effe7f4c3")!, title: "CleanCache_cluster", path: Bundle.main.path(forResource: "CleanCache_cluster", ofType: "sh")),
            ]
        )
    }
}
