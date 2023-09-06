//
//  GetScripts.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import WebKit

extension API {
    // MARK: - Scripts GET: https://api.42box.kr/user-service/users/me/scripts
    // result : scripts.shared 저장
    
    static func getUserMeScripts() {
        WebViewManager.shared.storageSetCookie()
        fetchDataFromAPI(withURL: "https://api.42box.kr/user-service/users/me/scripts", forType: [Script].self) { (result: Result<[Script], Error>) in
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
    
    static func initializeUserMeScripts() {
        WebViewManager.shared.storageSetCookie()
        
        fetchDataFromAPI(withURL: "https://api.42box.kr/user-service/users/me/scripts", forType: [Script].self) { (result: Result<[Script], Error>) in
            switch result {
            case .success(let scripts):
                print(">> Initalize Script MacOS Get :", scripts)
                DispatchQueue.main.async {
                    ScriptViewModel.shared.setupScripts(with: scripts)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
