//
//  QuickSlotItemButton.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import AppKit

class QuickSlotItemButton: NSButton {
    
    var viewModel = QuickSlotViewModel.shared
    
    init(_ item: Int) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: QuickSlotUI.size.button, height: QuickSlotUI.size.button)
        let buttonModel = viewModel.buttons[item]
        self.title = buttonModel.title
        if buttonModel.title == "CleanCache" {
            self.image = NSImage(imageLiteralResourceName: "trash")
        } else if buttonModel.title == "Preferences" {
            self.image = NSImage(imageLiteralResourceName: "box-icon-64")
        } else if buttonModel.type == "sh" {
            self.image = NSImage(imageLiteralResourceName: "document-text")
        } else if buttonModel.type == "pref" {
            self.image = NSImage(imageLiteralResourceName: "setting")
        } else if buttonModel.type == "default-sh" {
            self.image = NSImage(imageLiteralResourceName: "document-text")
        } else if buttonModel.type == "default-pref" {
            self.image = NSImage(imageLiteralResourceName: "setting")
        }
        self.target = self
        self.action = #selector(mouseEntered)
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor // 흰색 배경 색상
        self.layer?.cornerRadius = 8.0
        self.layer?.zPosition = 1
        let trackingArea = NSTrackingArea(
            rect: self.bounds, // 뷰의 경계를 기준으로 할 경우
            options: [.mouseEnteredAndExited, .activeAlways],
            owner: self,
            userInfo: nil
        )
        self.addTrackingArea(trackingArea)
        
        // MARK: - 퀵슬롯 button에 associatedString 부여
        self.associatedString = buttonModel.path
        print(self.associatedString)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
    
        self.wantsLayer = true
//        self.layer?.frame.size = CGSize(width: 58.0, height: 58.0)
        self.layer?.backgroundColor = NSColor(red: 0.848, green: 0.848, blue: 0.848, alpha: 1).cgColor
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        
        wantsLayer = true
//        layer?.frame.size = CGSize(width: 58.0, height: 58.0)
        layer?.backgroundColor = NSColor.white.cgColor
    }
}
