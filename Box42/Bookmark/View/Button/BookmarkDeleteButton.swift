//
//  BookmarkDeleteButton.swift
//  Box42
//
//  Created by Chanhee Kim on 9/5/23.
//

import AppKit

class BookmarkDeleteButton: NSButton {
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 53, height: 40))

        self.title = "삭제"
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.cornerRadius = WindowButtonUI.size.cornerRadius
        self.layer?.backgroundColor = NSColor(hex: "#F36161").cgColor

        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        self.layer?.backgroundColor = NSColor(hex: "#F36161").withAlphaComponent(0.5).cgColor
//        let bgColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
//        bgColorAnimation.fromValue = WindowButtonUI.color.opacityWhite
//        bgColorAnimation.toValue = WindowButtonUI.color.close
//        bgColorAnimation.duration = WindowButtonUI.animation.duration
//
//        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
//        cornerAnimation.fromValue = WindowButtonUI.size.cornerRadius
//        cornerAnimation.toValue = WindowButtonUI.size.cornerRadius / 2
//        cornerAnimation.duration = WindowButtonUI.animation.duration
//
//        self.layer?.add(bgColorAnimation, forKey: "backgroundColorAnimation")
//        self.layer?.add(cornerAnimation, forKey: "cornerRadiusAnimation")
//
//        self.layer?.backgroundColor = WindowButtonUI.color.close
//        self.layer?.cornerRadius = WindowButtonUI.size.cornerRadius / 2
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        self.layer?.backgroundColor = NSColor(hex: "#F36161").cgColor
//        let bgColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
//        bgColorAnimation.fromValue = WindowButtonUI.color.close
//        bgColorAnimation.toValue = WindowButtonUI.color.opacityWhite
//        bgColorAnimation.duration = WindowButtonUI.animation.duration
//
//        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
//        cornerAnimation.fromValue = WindowButtonUI.size.cornerRadius / 2
//        cornerAnimation.toValue = WindowButtonUI.size.cornerRadius
//        cornerAnimation.duration = WindowButtonUI.animation.duration
//
//        self.layer?.add(bgColorAnimation, forKey: "backgroundColorAnimation")
//        self.layer?.add(cornerAnimation, forKey: "cornerRadiusAnimation")
//
//        self.layer?.backgroundColor = WindowButtonUI.color.opacityWhite
//        self.layer?.cornerRadius = WindowButtonUI.size.cornerRadius
    }
}
