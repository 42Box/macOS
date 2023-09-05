//
//  QuickSlotCellDeleteButton.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import AppKit

class QuickSlotCellDeleteButton: NSButton {
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 0, height: 0))
        self.title = "삭제"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: NSColor.white
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.attributedTitle = attributedTitle
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.cornerRadius = 15
        self.layer?.backgroundColor = NSColor.red.cgColor
    }

    override func layout() {
        super.layout()

        for trackingArea in self.trackingAreas {
            self.removeTrackingArea(trackingArea)
        }
        
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)

        self.layer?.backgroundColor = NSColor(red: 1, green: 0, blue: 0, alpha: 0.5).cgColor
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)

        self.layer?.backgroundColor = NSColor.red.cgColor
    }
}
