//
//  Shared.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import WebKit

class API {
    // GET
    static func fetchDataFromAPI<T: Decodable>(withURL urlString: String, forType type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpShouldHandleCookies = true
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
                return
            }
            
            let jsonString = String(data: data, encoding: .utf8)
            print("Received JSON string:\n\(jsonString ?? "")")
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Received data:\n\(json)")
                }
                
                let decodedData = try JSONDecoder().decode(type, from: data)
                completion(.success(decodedData))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
    
    // DELETE
    static func deleteDataFromAPI(withURL urlString: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpShouldHandleCookies = true
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "InvalidStatusCode", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
