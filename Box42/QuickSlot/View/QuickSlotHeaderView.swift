//
//  QuickSlotHeaderView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit
import SnapKit

class QuickSlotHeaderView: NSView {
    
    private var callback: (() -> Void)?
    private var QuickSlotHeaderButton: NSButton!
    private var QuickSlotHeaderLabel: NSTextField!
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        QuickSlotHeaderButton = NSButton(image: image, target: self, action: #selector(pin))
        QuickSlotHeaderButton.isBordered = false
        QuickSlotHeaderButton.wantsLayer = true
        QuickSlotHeaderButton.layer?.backgroundColor = NSColor.clear.cgColor
        
        self.addSubview(QuickSlotHeaderButton)
        
        QuickSlotHeaderLabel = NSTextField(labelWithString: "Quick Slot")
        QuickSlotHeaderLabel.font = NSFont(name: "Inter", size: QuickSlotUI.size.font)
        QuickSlotHeaderLabel.textColor = NSColor(hex: "#696969")
        QuickSlotHeaderLabel.backgroundColor = NSColor.clear
        QuickSlotHeaderLabel.isBordered = false
        
        self.addSubview(QuickSlotHeaderLabel)
        
        QuickSlotHeaderButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
        
        QuickSlotHeaderLabel.snp.makeConstraints { make in
            make.left.equalTo(QuickSlotHeaderButton.snp.right).offset(4)
            make.bottom.equalTo(QuickSlotHeaderButton.snp.bottom)
        }
        
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pin() {
        callback?()
    }
}
