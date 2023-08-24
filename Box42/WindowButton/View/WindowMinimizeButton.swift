//
//  WindowMinimizeButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit

class WindowMinimizeButton: NSButton {
    
    private var callback: (() -> Void)?
    
    init(completion: @escaping () -> Void) {
        super.init(frame: NSRect(x: 0, y: 0, width: 21, height: 21))

        self.title = ""
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.cornerRadius = 21 / 2
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.target = self
        self.action = #selector(minimizeAction)
        self.callback = completion

        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func minimizeAction() {
        callback?()
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 2
            self.layer?.backgroundColor = NSColor.yellow.cgColor
        }, completionHandler: nil)
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 2
            self.layer?.backgroundColor = NSColor.white.cgColor
        }, completionHandler: nil)
    }
}
