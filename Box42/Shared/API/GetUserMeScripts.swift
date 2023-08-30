//
//  GetScripts.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import WebKit

extension API {
    // MARK: - Scripts GET: https://api.42box.site/user-service/users/me/scripts
    // result : scripts.shared 저장
    
    static func getUserMeScripts(_ webView: WKWebView) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieStorage = HTTPCookieStorage.shared
            for cookie in cookies {
                cookieStorage.setCookie(cookie)
            }
            
            fetchDataFromAPI(withURL: "https://api.42box.site/user-service/users/me/scripts", forType: [Script].self) { (result: Result<[Script], Error>) in
                switch result {
                case .success(let scripts):
                    print(">> MacOS Get :", scripts)
                    DispatchQueue.main.async {
                        ScriptViewModel.shared.replaceScripts(with: scripts)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
