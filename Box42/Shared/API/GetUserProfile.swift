//
//  UserProfile.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import WebKit

class API {
    // MARK: - 유저 정보 (Back) GET: https://api.42box.site/user-service/users/me
    // return : 실패 nil 반환
    //        : 성공 UserProfile()
    static func getUserProfile(_ webView: WKWebView) {
        var userProfile: UserProfile?
        
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieStorage = HTTPCookieStorage.shared
            
            for cookie in cookies {
//                print("\(cookie.name) = \(cookie.value)")
                cookieStorage.setCookie(cookie)
            }
            
            var request = URLRequest(url: URL(string: "https://api.42box.site/user-service/users/me")!)
            request.httpShouldHandleCookies = true
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received.")
                    return
                }

                do {
                    userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                    
                    print(">> MacOS Get", userProfile)
                    UserManager.shared.updateUserProfile(newProfile: userProfile)
                    
                } catch let jsonError {
                    print("JSON Parsing Error: \(jsonError)")
                }
            }
            task.resume()
        }
    }
}
