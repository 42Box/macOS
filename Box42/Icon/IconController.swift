//
//  IconController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import Foundation

class IconController {
    let icon = MenubarViewController()
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleUserProfileIconUpdate),
                                               name: .didUpdateUserProfile,
                                               object: nil)
    }
    
    @objc private func handleUserProfileIconUpdate() {
        DispatchQueue.main.async {
            self.icon.buttonImageChange(UserManager.shared.getUserProfile()?.icon ?? "fox")
        }
        print("Icon Changed")
    }
}
