//
//  SecurityScopedResourceAccess.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import Foundation

class SecurityScopedResourceAccess {
    private static let queue = DispatchQueue(label: "com.yourApp.securityAccessQueue", attributes: .concurrent)
    private static var isAccessing = false
    static var bookmarkData: Data? {
        get {
            return UserDefaults.standard.data(forKey: "bookmarkData")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bookmarkData")
        }
    }

    static func accessResourceExecuteShellScript(scriptPath: String) {
        queue.async(flags: .barrier) {
            var url: URL? = nil // 이 부분을 추가하여 url 변수의 스코프를 확장합니다.
            do {
                var staleBookmarkData = false
                guard let bookmarkData = self.bookmarkData else {
                    print("Bookmark data not available.")
                    return
                }
                
                print("Stored bookmark data: \(String(describing: UserDefaults.standard.data(forKey: "bookmarkData")))")

                
                url = try URL(resolvingBookmarkData: bookmarkData, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &staleBookmarkData)
                
                if staleBookmarkData {
                    // Refresh the bookmark data and save it.
                }
                
                isAccessing = url?.startAccessingSecurityScopedResource() ?? false
                
                // Perform work here
                if isAccessing {
                    ExecuteScripts.executeShellScript(path: scriptPath)
                }
                
            } catch {
                print("An error occurred: \(error)")
            }
            
            // Cleanup
            if isAccessing {
                // Make sure to match this with a call to startAccessingSecurityScopedResource()
                url?.stopAccessingSecurityScopedResource()
            }
        }
    }
}
