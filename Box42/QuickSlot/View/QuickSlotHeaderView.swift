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
    private var quickSlotHeaderButton: NSButton!
    private var quickSlotHeaderLabel: NSTextField!
    private var quickSlotManageButton: NSButton!
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        quickSlotHeaderButton = NSButton(image: image, target: self, action: #selector(btnAction))
        quickSlotHeaderButton.isBordered = false
        quickSlotHeaderButton.wantsLayer = true
        quickSlotHeaderButton.layer?.backgroundColor = NSColor.clear.cgColor
        
        self.addSubview(quickSlotHeaderButton)
        
        quickSlotHeaderLabel = NSTextField(labelWithString: "Quick Slot")
        quickSlotHeaderLabel.font = NSFont(name: "Inter", size: QuickSlotUI.size.font)
        quickSlotHeaderLabel.textColor = NSColor(hex: "#696969")
        quickSlotHeaderLabel.backgroundColor = NSColor.clear
        quickSlotHeaderLabel.isBordered = false
        
        self.addSubview(quickSlotHeaderLabel)
        
        quickSlotManageButton = NSButton(image: NSImage(imageLiteralResourceName: "add"), target: self, action: #selector(btnAction))
        quickSlotManageButton.isBordered = false
        quickSlotManageButton.wantsLayer = true
        quickSlotManageButton.layer?.backgroundColor = NSColor.clear.cgColor
        
        self.addSubview(quickSlotManageButton)
       
        quickSlotHeaderButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
        
        quickSlotHeaderLabel.snp.makeConstraints { make in
            make.left.equalTo(quickSlotHeaderButton.snp.right).offset(4)
            make.bottom.equalTo(quickSlotHeaderButton.snp.bottom)
        }
        
        quickSlotManageButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(quickSlotHeaderLabel.snp.bottom)
        }
        
        
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnAction() {
        callback?()
    }
}
