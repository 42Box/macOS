//
//  QuickSlotItemLabel.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import AppKit

class QuickSlotItemLabel: NSTextField {
    
    var viewModel = QuickSlotViewModel.shared
    
    init(_ item: Int) {
        super.init(frame: .zero)
        let buttonModel = viewModel.buttons[item]
        
        self.stringValue = buttonModel.title
        self.font = NSFont(name: "Inter", size: QuickSlotUI.size.font)
        self.textColor = NSColor(hex: "#696969")
        self.backgroundColor = NSColor.clear
        self.isBordered = false
        self.alignment = .center
        self.isSelectable = false
        self.isEditable = false
        self.lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
