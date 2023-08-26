//
//  PinButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import AppKit
import SnapKit

class PinButtonView: NSView {
    
    private var callback: (() -> Void)?
    private var pinBoxButton: NSButton!
    private var pinBoxLabel: NSTextField!
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        pinBoxButton = NSButton(image: image, target: self, action: #selector(pin))
        pinBoxButton.isBordered = false
        pinBoxButton.wantsLayer = true
        pinBoxButton.layer?.backgroundColor = NSColor.clear.cgColor
        
        self.addSubview(pinBoxButton)
        
        pinBoxLabel = NSTextField(labelWithString: "Pin Box")
        pinBoxLabel.font = NSFont(name: "Inter", size: 14)
        pinBoxLabel.textColor = NSColor(hex: "#696969")
        pinBoxLabel.backgroundColor = NSColor.clear
        pinBoxLabel.isBordered = false
        
        self.addSubview(pinBoxLabel)
        
        pinBoxButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        pinBoxLabel.snp.makeConstraints { make in
            make.left.equalTo(pinBoxButton.snp.right).offset(2)
            make.centerY.equalToSuperview()
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
