//
//  ScriptExcuteButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import AppKit

class ScriptExcuteButton: NSButton {
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 70, height: 40))

        self.title = "실행하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 13, weight: .medium),
            .foregroundColor: NSColor.white
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.attributedTitle = attributedTitle
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.cornerRadius = 15
        self.layer?.backgroundColor = NSColor(hex: "#008000").cgColor

        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)

        self.layer?.backgroundColor = NSColor(hex: "#008000").withAlphaComponent(0.5).cgColor
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)

        self.layer?.backgroundColor = NSColor(hex: "#008000").cgColor
    }
}
