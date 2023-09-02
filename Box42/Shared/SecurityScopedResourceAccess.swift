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
            var url: URL? = nil
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
                
                if isAccessing {
                    ExecuteScripts.executeShellScript(path: scriptPath)
                }
                
            } catch {
                print("An error occurred: \(error)")
            }
            
            if isAccessing {
                url?.stopAccessingSecurityScopedResource()
            }
        }
    }
}
