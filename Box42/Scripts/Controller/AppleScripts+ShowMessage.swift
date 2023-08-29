//
//  AppleScripts+ShowMessage.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Foundation
import AppKit

func showMessageWithAppleScript(_ message: String) {
    let appleScript = """
    display dialog "\(message)" buttons {"OK"} default button "OK"
    """
    
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: appleScript) {
        scriptObject.executeAndReturnError(&error)
        if let error = error {
            print("AppleScript Error: \(error)")
        }
    }
}

func showMessageWithAppleScript(_ message: String, _ button: String, completion: @escaping (String?) -> Void) {
    let appleScript = """
    display dialog "\(message)" buttons {"\(button)", "취소"} default button "\(button)"
    """
    
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: appleScript) {
        let output = scriptObject.executeAndReturnError(&error)
        let buttonReturned = output.forKeyword(keyDirectObject)
        print("output", output.description)
//        completion(output.stringValue)
        completion(buttonReturned?.stringValue)
        if let error = error {
            print("AppleScript Error: \(error)")
            completion(nil)
        }
    }
}
