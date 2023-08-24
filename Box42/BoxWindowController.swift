//
//  BoxWindowController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxWindowController: NSWindowController, NSWindowDelegate {
    override init(window: NSWindow?) {
        let contentRect = BoxSizeManager.shared.boxViewSizeNSRect
        let styleMask: NSWindow.StyleMask = [.resizable, .titled, .fullSizeContentView, .closable, .miniaturizable]
        let windowInstance = NSWindow(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)
        super.init(window: windowInstance)
        windowInstance.delegate = self

        windowInstance.title = "Box"
        windowInstance.titlebarAppearsTransparent = true
        windowInstance.titleVisibility = .hidden
        windowInstance.isReleasedWhenClosed = false
        windowInstance.isMovableByWindowBackground = true

        let boxViewController = BoxBaseContainerViewController(nibName: nil, bundle: nil)
        windowInstance.contentViewController = boxViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxWindowController {
    func windowWillClose(_ notification: Notification) {
        StateManager.shared.showWindow = false
    }

    func windowWillMiniaturize(_ notification: Notification) {
        StateManager.shared.showWindow = false
    }
}
