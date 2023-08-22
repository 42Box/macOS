//
//  HoverButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

class HoverButton: NSButton {
    
    private var trackingArea: NSTrackingArea?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.wantsLayer = true
        self.layer?.borderColor = NSColor.black.cgColor
        self.layer?.borderWidth = 1.0
        self.layer?.cornerRadius = 5.0
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        if let trackingArea = self.trackingArea {
            self.removeTrackingArea(trackingArea)
        }
        
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
        trackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
    
    override func mouseEntered(with event: NSEvent) {
        // 호버 상태일 때의 스타일을 정의합니다.
        self.layer?.backgroundColor = NSColor.gray.cgColor
        self.layer?.opacity = 1.0
    }
    
    override func mouseExited(with event: NSEvent) {
        // 호버 상태가 아닐 때의 스타일을 정의합니다.
//        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.opacity = 0.7
    }
}
