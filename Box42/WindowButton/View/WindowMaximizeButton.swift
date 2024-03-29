//
//  WindowMaximizeButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit

class WindowMaximizeButton: NSButton {
    
    private var callback: (() -> Void)?
    
    init(completion: @escaping () -> Void) {
        super.init(frame: NSRect(x: 0, y: 0, width: WindowButtonUI.size.diameter, height: WindowButtonUI.size.diameter))

        self.title = ""
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.cornerRadius = WindowButtonUI.size.cornerRadius
        self.layer?.backgroundColor = WindowButtonUI.color.opacityWhite
        self.target = self
        self.action = #selector(maximizeAction)
        self.callback = completion

        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func maximizeAction() {
        callback?()
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)

        let bgColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        bgColorAnimation.fromValue = WindowButtonUI.color.opacityWhite
        bgColorAnimation.toValue = WindowButtonUI.color.maximize
        bgColorAnimation.duration = WindowButtonUI.animation.duration

        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = WindowButtonUI.size.cornerRadius
        cornerAnimation.toValue = WindowButtonUI.size.cornerRadius / 2
        cornerAnimation.duration = WindowButtonUI.animation.duration

        self.layer?.add(bgColorAnimation, forKey: "backgroundColorAnimation")
        self.layer?.add(cornerAnimation, forKey: "cornerRadiusAnimation")

        self.layer?.backgroundColor = WindowButtonUI.color.maximize
        self.layer?.cornerRadius = WindowButtonUI.size.cornerRadius / 2
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)

        let bgColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        bgColorAnimation.fromValue = WindowButtonUI.color.maximize
        bgColorAnimation.toValue = WindowButtonUI.color.opacityWhite
        bgColorAnimation.duration = WindowButtonUI.animation.duration
        
        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = WindowButtonUI.size.cornerRadius / 2
        cornerAnimation.toValue = WindowButtonUI.size.cornerRadius
        cornerAnimation.duration = WindowButtonUI.animation.duration

        self.layer?.add(bgColorAnimation, forKey: "backgroundColorAnimation")
        self.layer?.add(cornerAnimation, forKey: "cornerRadiusAnimation")

        self.layer?.backgroundColor = WindowButtonUI.color.opacityWhite
        self.layer?.cornerRadius = WindowButtonUI.size.cornerRadius
    }
}
