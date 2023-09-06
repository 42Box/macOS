//
//  QuickSlotScriptsLogicController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//
import Cocoa
import AppKit

class QuickSlotScriptsLogicController {
    static let shared = QuickSlotScriptsLogicController()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTapped), name: .collectionButtonTapped, object: nil)
    }
    
    @objc func handleButtonTapped(notification: NSNotification) {
        if let button = notification.object as? NSButton {
            if let associatedString = button.associatedString {
                if associatedString == "default_script_file/cleanCache.sh" {
//                    runScriptAndDisplayOutput()
                    SecurityScopedResourceAccess.accessResourceExecuteShellScriptCleanCache()
                } else if let lastThreeCharacters = button.associatedString?.suffix(3) {
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
    
//    func runScriptAndDisplayOutput() {
//        // 새로운 윈도우 생성
//        let newWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 500, height: 300), styleMask: [.titled, .closable], backing: .buffered, defer: false)
//        newWindow.title = "Script Output"
//
//        let outputTextField = NSTextField(frame: NSRect(x: 20, y: 20, width: 460, height: 260))
//        outputTextField.isEditable = false
//        outputTextField.isBordered = true
//        newWindow.contentView?.addSubview(outputTextField)
//
//        newWindow.makeKeyAndOrderFront(nil)
//
//        // 스크립트 실행 및 결과 출력
//        if let scriptPath = Bundle.main.path(forResource: "CleanCache_cluster", ofType: "sh") {
//            let task = Process()
//            task.launchPath = "/bin/sh"
//            task.arguments = [scriptPath]
//
//            let pipe = Pipe()
//            task.standardOutput = pipe
//            task.launch()
//
//            let data = pipe.fileHandleForReading.readDataToEndOfFile()
//            if let output = String(data: data, encoding: .utf8) {
//                outputTextField.stringValue = output
//            }
//
//            task.waitUntilExit()
//        } else {
//            print("Script not found")
//        }
//    }

}
