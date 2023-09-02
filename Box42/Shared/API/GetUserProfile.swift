//
//  UserProfile.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import WebKit

extension API {
    // MARK: - 유저 정보 (Back) GET: https://api.42box.kr/user-service/users/me
    // result : 성공 UserProfile.shared 저장
    
    static func getUserProfile(_ webView: WKWebView) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieStorage = HTTPCookieStorage.shared
            for cookie in cookies {
                cookieStorage.setCookie(cookie)
            }
            
            fetchDataFromAPI(withURL: "https://api.42box.kr/user-service/users/me", forType: UserProfile.self) { (result: Result<UserProfile, Error>) in
                switch result {
                case .success(let userProfile):
                    print(">> User MacOS Get :", userProfile)
                    UserManager.shared.updateUserProfile(newProfile: userProfile)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
