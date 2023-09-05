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
    //    private var quickSlotHeaderButton: NSButton!
    private var quickSlotIcon: NSImageView!
    private var quickSlotHeaderLabel: NSTextField!
    private var quickSlotManageButton: NSButton!
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        quickSlotIcon = NSImageView()
        quickSlotIcon.image = image
        quickSlotIcon.image?.size = NSSize(width: 18, height: 18)
        self.addSubview(quickSlotIcon)
        
        quickSlotHeaderLabel = NSTextField(labelWithString: "퀵슬롯")
        quickSlotHeaderLabel.font = NSFont.boldSystemFont(ofSize: 16)
        quickSlotHeaderLabel.textColor = NSColor.black
        quickSlotHeaderLabel.backgroundColor = NSColor.clear
        quickSlotHeaderLabel.isBordered = false
        self.addSubview(quickSlotHeaderLabel)
        
        let buttonImage = NSImage(named: NSImage.Name("add"))!
        buttonImage.size = NSSize(width: 24, height: 24)
        quickSlotManageButton = NSButton(image: buttonImage, target: self, action: #selector(btnAction))
        quickSlotManageButton.setButtonType(.momentaryChange)
        quickSlotManageButton.bezelStyle = .texturedRounded
        quickSlotManageButton.isBordered = false
        quickSlotManageButton.wantsLayer = true
        quickSlotManageButton.layer?.backgroundColor = NSColor.clear.cgColor
        self.addSubview(quickSlotManageButton)
        
        quickSlotIcon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        quickSlotHeaderLabel.snp.makeConstraints { make in
            make.left.equalTo(quickSlotIcon.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        quickSlotManageButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
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
