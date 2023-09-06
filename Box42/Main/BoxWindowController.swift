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
        let styleMask: NSWindow.StyleMask = [.resizable, .titled, .fullSizeContentView]
        let windowInstance = NSWindow(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)
        super.init(window: windowInstance)
        windowInstance.delegate = self

        windowInstance.title = "Box"
        windowInstance.titlebarAppearsTransparent = true
        windowInstance.titleVisibility = .hidden
        windowInstance.isMovableByWindowBackground = true
        windowInstance.isReleasedWhenClosed = false
        windowInstance.standardWindowButton(.closeButton)?.isHidden = true
        windowInstance.standardWindowButton(.miniaturizeButton)?.isHidden = true
        windowInstance.standardWindowButton(.zoomButton)?.isHidden = true
        windowInstance.level = .floating

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
