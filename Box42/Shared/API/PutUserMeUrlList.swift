//
//  PutUserMeUrlList.swift
//  Box42
//
//  Created by Chanhee Kim on 9/5/23.
//

import WebKit

extension API {
    // MARK: - Scripts PUT: https://api.42box.kr/user-service/users/me/url-list
    // TODO: refactoring 필수
    static func putUserMeUrlList(urlList: URLList, completion: @escaping (Result<Void, Error>) -> Void) {
        
        WebViewManager.shared.storageSetCookie()
        
        let url = "https://api.42box.kr/user-service/users/me/url-list"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.httpShouldHandleCookies = true
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Scripts 객체를 JSON 데이터로 인코딩
        print(urlList)
        do {
            let jsonData = try JSONEncoder().encode(urlList)
            request.httpBody = jsonData
            print(request.httpBody!)
        } catch {
            print("Failed to encode scripts: \(error)")
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "InvalidStatusCode", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            completion(.success(()))
        }
        task.resume()
    }
}
