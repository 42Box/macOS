//
//  WindowMaximizeButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit

class WindowMaximizeButton: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.title = "□"  // 기본적인 □ 모양으로 표시. 변경 가능.
        self.bezelStyle = .texturedRounded
        self.target = self
        self.action = #selector(maximizeAction)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func maximizeAction() {
        callback?()
    }
}
