//
//  QuickSlotScriptsLogicController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import AppKit

class QuickSlotScriptsLogicController {
    static let shared = QuickSlotScriptsLogicController()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTapped), name: .collectionButtonTapped, object: nil)
    }
    
    @objc func handleButtonTapped(notification: NSNotification) {
        if let button = notification.object as? NSButton {
            if let associatedString = button.associatedString {
                if let lastThreeCharacters = button.associatedString?.suffix(3) {
                    if lastThreeCharacters == ".sh" {
                        ScriptsFileManager.downloadFile(from: "https://42box.kr/" + associatedString)
                    }
                }
            }
        }
    }
    
    func shortCutKeyUP(_ keyCode: Int) {
        if QuickSlotViewModel.shared.buttons.count > keyCode {
            if let lastThreeCharacters = QuickSlotViewModel.shared.buttons[keyCode].path?.suffix(3) {
                if lastThreeCharacters == ".sh" {
                    ScriptsFileManager.downloadFile(from: "https://42box.kr/" + QuickSlotViewModel.shared.buttons[keyCode].path!)
                }
            }
        }
    }
}
