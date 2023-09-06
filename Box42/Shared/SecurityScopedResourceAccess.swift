//
//  SecurityScopedResourceAccess.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import Foundation
import Cocoa

class SecurityScopedResourceAccess {
    private static let queue = DispatchQueue(label: "com.yourApp.securityAccessQueue", attributes: .concurrent)
    private static var isAccessing = false
    private static var newWindow: NSWindow?
    
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
    
    static func accessResourceExecuteShellScriptCleanCache() {
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
                    if let scriptPath = Bundle.main.path(forResource: "CleanCache_cluster", ofType: "sh") {
                        let task = Process()
                        task.launchPath = "/bin/sh"
                        task.arguments = [scriptPath]
                        
                        task.launch()
                        task.waitUntilExit()

                        // 실행되었다는 것을 알려주고 싶으면 파이프 뽑아서 하면됨.
                    } else {
                        print("Script not found")
                    }
                }
                
            } catch {
                print("An error occurred: \(error)")
            }
            
            if isAccessing {
                url?.stopAccessingSecurityScopedResource()
            }
        }
    }
    
    static func accessResourceExecuteShellScriptWithNewWindow(scriptPath: String) {
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
                    DispatchQueue.main.async {
                        displayOutputInNewWindow()
                    }
                    ExecuteScripts.executeShellScriptNewWindow(path: scriptPath)

                }
                
            } catch {
                print("An error occurred: \(error)")
            }
            
            if isAccessing {
                url?.stopAccessingSecurityScopedResource()
            }
        }
    }
    
    private static func displayOutputInNewWindow() {
        guard let mainWindow = NSApp.mainWindow else { return }
        
        if newWindow == nil {
            let midX = mainWindow.frame.midX
            let midY = mainWindow.frame.midY
            let halfWidth = mainWindow.frame.width / 2
            let halfHeight = mainWindow.frame.height / 4

            let windowOriginX = midX - halfWidth / 2
            let windowOriginY = midY - halfHeight / 2

            let newWindowFrame = NSRect(x: windowOriginX, y: windowOriginY, width: halfWidth, height: halfHeight)
            newWindow = NSWindow(contentRect: newWindowFrame, styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
            newWindow?.title = "Script Output"

            let scrollView = NSScrollView(frame: newWindow!.contentView!.bounds)
            scrollView.hasVerticalScroller = true
            scrollView.autoresizingMask = [.width, .height]
            
            let textView = NSTextView(frame: scrollView.bounds)
            textView.isEditable = false
            scrollView.documentView = textView
            newWindow?.contentView?.addSubview(scrollView)
            
            newWindow?.level = .floating
            ExecuteScripts.outputTextView = textView
        }
        
        newWindow?.makeKeyAndOrderFront(nil)
    }

}
