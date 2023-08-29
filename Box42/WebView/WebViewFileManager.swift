//
//  WebViewFileManager.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import Foundation

class WebViewFileManager {
    static func downloadFile(from URLString: String) {
        let fileManager = FileManager.default
        let pathComponent = URLString.split(separator: "/").map { String($0) }.last ?? ""
        let documentsURL = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let savedURL = documentsURL?.appendingPathComponent(pathComponent)
        
        if let savedURL = savedURL, fileManager.fileExists(atPath: savedURL.path) {
            print("File already exists, executing...")
            ExcuteScripts.executeShellScript(path: savedURL.path)
            return
        }
        
        guard let url = URL(string: URLString) else {
            print("Invalid URL: \(URLString)")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { (location, _, error) in
            guard let location = location else {
                print("Download failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let savedURL = documentsURL.appendingPathComponent(pathComponent)
                try fileManager.moveItem(at: location, to: savedURL)
                
                print("Saved URL: ", savedURL)
                
                ExcuteScripts.executeShellScript(path: savedURL.path)
                
            } catch {
                print("File error: \(error)")
            }
        }
        task.resume()
    }
}
