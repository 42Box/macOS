//
//  GoBackInToolbar.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit

class GoBackInToolbar: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.image = image
        self.bezelStyle = .texturedRounded
        self.target = self
        self.action = #selector(goBackWebView)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goBackWebView() {
        callback?()
    }
}
