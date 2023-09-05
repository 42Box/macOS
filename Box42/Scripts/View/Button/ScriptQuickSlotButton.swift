//
//  ScriptQuickSlotButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import AppKit

class ScriptQuickSlotButton: NSButton {
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 53, height: 40))

        self.title = "퀵슬롯"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 13, weight: .medium),
            .foregroundColor: NSColor.white
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.attributedTitle = attributedTitle
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.cornerRadius = 15
        self.layer?.backgroundColor = NSColor(hex: "#FFCE51").cgColor

        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)

        self.layer?.backgroundColor = NSColor(hex: "#FFCE51").withAlphaComponent(0.5).cgColor
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)

        self.layer?.backgroundColor = NSColor(hex: "#FFCE51").cgColor
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        // 윈도우의 크기와 위치 정보를 가져옴
        guard self.window != nil else {
            return
        }
        if self.title == "퀵슬롯" { return }
        // 현재 버튼의 위치를 윈도우 기준으로 변환
        let initialLocation = self.frame.origin
        
        // 윈도우의 왼쪽 아래 모서리를 최종 목표 위치로 설정
        let finalLocation = NSPoint(x: 0, y: 0)
        
        // 애니메이션 블록
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 1 // 애니메이션 지속 시간
            
            // 애니메이션 적용
            self.animator().setFrameOrigin(finalLocation)
        }, completionHandler: {
            // 애니메이션 완료 후, 버튼을 원래 위치로 되돌림
            self.setFrameOrigin(initialLocation)
        })
    }
}
