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
        } else if buttonModel.type == "sh" {
            self.image = NSImage(imageLiteralResourceName: "document-text")
        } else if buttonModel.type == "pref" {
            self.image = NSImage(imageLiteralResourceName: "setting")
        }
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.associatedString = buttonModel.path
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
