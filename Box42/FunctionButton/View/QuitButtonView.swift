//
//  QuitButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import AppKit

class QuitButtonView: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.image = image
        self.isBordered = false  // 버튼의 테두리를 제거
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.target = self
        self.action = #selector(QuitButton)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func QuitButton() {
        callback?()
    }
}
