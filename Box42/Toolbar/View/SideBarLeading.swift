//
//  SideBarLeading.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit

class SideBarLeading: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.image = image
        self.isBordered = false  // 버튼의 테두리를 제거
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.target = self
        self.action = #selector(sideBarLeading)
        self.callback = completion
        self.wantsLayer = true
        self.layer?.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func runScript() {
        let scriptSource = """
                    tell application "System Preferences"
                        activate
                    end tell
                    """
        
        if let appleScript = NSAppleScript(source: scriptSource) {
            var errorDict: NSDictionary? = nil
            appleScript.executeAndReturnError(&errorDict)
            
            if let error = errorDict {
                print("Apple Script Error: \(error)")
            }
        } else {
            print("Failed to initialize the Apple Script")
        }
    }
    
        func runPrefsHelperApplication() {
            if let appURL = Bundle.main.url(forResource: "prefsHelper", withExtension: "app") {
                let workspace = NSWorkspace.shared
                do {
                    try workspace.open([appURL], withAppBundleIdentifier: nil, options: [], additionalEventParamDescriptor: nil, launchIdentifiers: nil)
                } catch {
                    print("Error opening app: \(error)")
                }
            } else {
                print("App not found")
            }
        }
//    func runPrefsHelperApplication() {
//        let prefsHelperAppPath = "/Users/solda/Downloads/prefsHelper.app" // prefsHelper.app의 경로
//
//        let appURL = URL(fileURLWithPath: prefsHelperAppPath)
//
//        let workspace = NSWorkspace.shared
//        do {
//            try workspace.open([appURL], withAppBundleIdentifier: nil, options: [], additionalEventParamDescriptor: nil, launchIdentifiers: nil)
//        } catch {
//            print("Error opening app: \(error)")
//        }
//    }
    
    
    @objc func sideBarLeading() {
//        runPrefsHelperApplication()
        callback?()
    }
}
