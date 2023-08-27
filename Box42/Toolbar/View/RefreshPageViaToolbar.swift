//
//  ReloadPageViaToolbar.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit

class ReloadPageViaToolbar: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.image = image
        self.isBordered = false  // 버튼의 테두리를 제거
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.wantsLayer = true
        self.layer?.backgroundColor = .clear
        self.target = self
        self.action = #selector(reloadWebView)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func reloadWebView() {
        callback?()
    }
}
