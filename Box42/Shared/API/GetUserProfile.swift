//
//  UserProfile.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import WebKit

extension API {
    // MARK: - 유저 정보 (Back) GET: https://api.42box.site/user-service/users/me
    // result : 성공 UserProfile.shared 저장
    
    static func getUserProfile(_ webView: WKWebView) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieStorage = HTTPCookieStorage.shared
            for cookie in cookies {
                cookieStorage.setCookie(cookie)
            }
            
            fetchDataFromAPI(withURL: "https://api.42box.site/user-service/users/me", forType: UserProfile.self) { (result: Result<UserProfile, Error>) in
                switch result {
                case .success(let userProfile):
                    print(">> MacOS Get :", userProfile)
                    UserManager.shared.updateUserProfile(newProfile: userProfile)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

//static func getUserProfile(_ webView: WKWebView) {
//    webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
//        let cookieStorage = HTTPCookieStorage.shared
//
//        for cookie in cookies {
////                print("\(cookie.name) = \(cookie.value)")
//            cookieStorage.setCookie(cookie)
//        }
//
//        var request = URLRequest(url: URL(string: "https://api.42box.site/user-service/users/me")!)
//        request.httpShouldHandleCookies = true
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received.")
//                return
//            }
//
//            do {
//                let userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
//
//                print(">> MacOS Get :", userProfile )
//                UserManager.shared.updateUserProfile(newProfile: userProfile)
//
//            } catch let jsonError {
//                print("JSON Parsing Error: \(jsonError)")
//            }
//        }
//        task.resume()
//    }
//}
//
