//
//  QuickSlotScriptsLogicController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import AppKit

class ScriptsLogicController {
    
    static let shared = ScriptsLogicController()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTapped), name: .collectionButtonTapped, object: nil)
    }
    
    @objc func handleButtonTapped(notification: NSNotification) {
        if let button = notification.object as? NSButton {
            let buttonTitle = button.title
            print("Button with title \(buttonTitle) was tapped")
            
            DispatchQueue.global(qos: .background).async { [weak self] in
                if buttonTitle == QuickSlotUI.title.clean {
                    self?.executeCleanScript()
                }
            }
        }
    }

    private func executeCleanScript() {
        if let scriptPath = Bundle.main.path(forResource: "cleanCache", ofType: "sh") {
            let task = Process()
            task.launchPath = "/bin/sh"
            task.arguments = [scriptPath]

            let outputPipe = Pipe()
            task.standardOutput = outputPipe
            task.standardError = outputPipe
                    
            task.launch()
            task.waitUntilExit()

            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: outputData, encoding: .utf8) ?? ""
            
            DispatchQueue.main.async {
                print("Output: \(output)")
            }
        } else {
            DispatchQueue.main.async {
                print("Script not found")
            }
        }
    }
}
