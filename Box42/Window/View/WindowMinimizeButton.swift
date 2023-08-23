//
//  WindowMinimizeButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit

class WindowMinimizeButton: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.title = "_"  // 기본적인 _ 모양으로 표시. 변경 가능.
        self.bezelStyle = .texturedRounded
        self.target = self
        self.action = #selector(minimizeAction)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func minimizeAction() {
        callback?()
    }
}
