//
//  Accessibility.swift
//  Box42
//
//  Created by Chanhee Kim on 8/8/23.
//

import Cocoa

func alertAccessibility() {
    let alert = NSAlert()
    alert.messageText = "Permission Required"
    alert.informativeText = "Please allow accessibility permissions in System Preferences to enable this feature."
    alert.addButton(withTitle: "Open System Preferences")
    alert.addButton(withTitle: "Cancel")
    let response = alert.runModal()
    
    if response == .alertFirstButtonReturn {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
            NSWorkspace.shared.open(url)
        }
    }
}
