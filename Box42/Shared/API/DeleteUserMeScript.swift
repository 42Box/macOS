//
//  DeleteUserMeScript.swift
//  Box42
//
//  Created by Chanhee Kim on 9/2/23.
//

import WebKit

extension API {
    // MARK: - Scripts DELETE: https://api.42box.kr/user-service/users/me/scripts/{savedId}
    static func deleteUserMeScripts(_ webView: WKWebView, savedId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://api.42box.kr/user-service/users/me/scripts/\(savedId)"
        
        deleteDataFromAPI(withURL: url) { (result: Result<Data?, Error>) in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
