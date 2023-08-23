//
//  WindowCloseButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit

class WindowCloseButton: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.title = "X"  // 기본적인 X 모양으로 표시. 이미지나 다른 디자인을 원하시면 변경하실 수 있습니다.
        self.bezelStyle = .texturedRounded
        self.target = self
        self.action = #selector(closeAction)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeAction() {
        callback?()
    }
}
