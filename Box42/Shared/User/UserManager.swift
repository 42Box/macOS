//
//  UserManager.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private var userProfile: UserProfile? {
        didSet {
            NotificationCenter.default.post(name: .didUpdateUserProfile, object: nil)
        }
    }
    private let fileBookmarkKey = "myFileAppSandBox"
    
    private init() {}
    
    // Create
    func createUserProfile(_ createProfile: UserProfile) {
        self.userProfile = createProfile
    }
    
    // Read
    func getUserProfile() -> UserProfile? {
        return self.userProfile
    }
    
    // Update
    func updateUserProfile(newProfile: UserProfile?) {
        if let new = newProfile {
            self.userProfile = new
        } else {
            self.userProfile = UserProfile.defaultProfile()
        }
    }
    
    // Delete
    func deleteUserProfile() {
        self.userProfile = nil
    }
    
    func userDefaults() {
        let fileURL = URL(fileURLWithPath: "~")
        
        do {
            let bookmarkData = try fileURL.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            UserDefaults.standard.set(bookmarkData, forKey: fileBookmarkKey)
        } catch {
            print("Failed to create bookmark data for file: \(error)")
            // TODO: Handle this error appropriately in your app.
        }
    }
    
    func userDefaultsRestore() {
        if let bookmarkData = UserDefaults.standard.data(forKey: fileBookmarkKey) {
            var isStale = false
            
            do {
                let restoredURL = try URL(resolvingBookmarkData: bookmarkData, options: .withSecurityScope,
                                          relativeTo:nil,
                                          bookmarkDataIsStale:&isStale)
                
                if isStale {
                    // Refresh the bookmark data and save it.
                    userDefaults()
                }
                
                if restoredURL.startAccessingSecurityScopedResource() {
                    restoredURL.stopAccessingSecurityScopedResource()
                }
                
            } catch {
                print("Failed to resolve bookmark data: \(error)")
                // TODO : Handle this error appropriately in your app.
            }
        }
    }
}

// MARK: - Notification Name didUpdateUserProfile
extension Notification.Name {
    static let didUpdateUserProfile = Notification.Name("didUpdateUserProfile")
}
