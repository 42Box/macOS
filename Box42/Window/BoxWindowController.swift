//
//  BoxWindowController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxWindowController: NSWindowController {
    
    override init(window: NSWindow?) {
        let contentRect = BoxSizeManager.shared.boxViewSizeNSRect
        let styleMask: NSWindow.StyleMask = [.titled, .closable, .resizable, .miniaturizable]
        let windowInstance = NSWindow(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)
        windowInstance.title = "Box"
        windowInstance.styleMask.insert(.resizable)

        let boxViewController = BoxViewController(nibName: nil, bundle: nil)
        windowInstance.contentViewController = boxViewController
        
        windowInstance.setContentSize(BoxSizeManager.shared.boxViewSizeNSSize)

        super.init(window: windowInstance)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
}
