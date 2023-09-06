//
//  ExecuteScripts.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import AppKit

class ExecuteScripts {
    static func executeShellScript(path: String) {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = [path]
        task.launch()
    }
    
    static var outputTextView: NSTextView?
    
    static func executeShellScriptNewWindow(path: String) {
        let task = Process()
        let pipe = Pipe()
        
        task.launchPath = "/bin/sh"
        task.arguments = [path]
        task.standardOutput = pipe
        
        pipe.fileHandleForReading.readabilityHandler = { handle in
            let data = handle.availableData
            if let output = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    outputTextView?.string += output
                    outputTextView?.scrollRangeToVisible(NSMakeRange((outputTextView?.string.count ?? 0) - 1, 1))
                }
            }
        }
        
        task.terminationHandler = { _ in
            DispatchQueue.main.async {
                outputTextView?.scrollRangeToVisible(NSMakeRange((outputTextView?.string.count ?? 0) - 1, 1))
            }
            pipe.fileHandleForReading.readabilityHandler = nil
        }
        
        task.launch()
    }
}
