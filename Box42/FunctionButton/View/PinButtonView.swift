//
//  PinButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import AppKit

class PinButtonView: NSButton {
    
    private var callback: (() -> Void)?
    private var pinBoxLabel: NSTextField!
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.image = image
        self.isBordered = false
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.target = self
        self.action = #selector(pin)
        self.callback = completion
        
        pinBoxLabel = NSTextField(labelWithString: "Pin Box")
        pinBoxLabel.font = NSFont(name: "Inter", size: FunctionButtonUI.size.font)
        pinBoxLabel.textColor = FunctionButtonUI.color.pinText
        pinBoxLabel.backgroundColor = NSColor.clear
        pinBoxLabel.isBordered = false
        
        self.addSubview(pinBoxLabel)  // 라벨을 버튼에 추가
        
        // 레이아웃을 설정 (예: AutoLayout)
        pinBoxLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinBoxLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pinBoxLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pin() {
        callback?()
    }
}
