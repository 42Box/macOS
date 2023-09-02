//
//  PutUserMeQuickSlot.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import WebKit

extension API {
    // MARK: - Scripts PUT: https://api.42box.kr/user-service/users/me/quick-slot
    // TODO: refactoring 필수
    static func putUserMeQuickSlot(quickSlots: QuickSlotModels, completion: @escaping (Result<Void, Error>) -> Void) {
        
        WebViewManager.shared.hostingWebView?.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieStorage = HTTPCookieStorage.shared
            for cookie in cookies {
                cookieStorage.setCookie(cookie)
            }
            
            let url = "https://api.42box.kr/user-service/users/me/quick-slot"
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "PUT"
            request.httpShouldHandleCookies = true
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Scripts 객체를 JSON 데이터로 인코딩
            print(quickSlots)
            do {
                let jsonData = try JSONEncoder().encode(quickSlots)
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
}
