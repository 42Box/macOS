//
//  BoxFunctionButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import AppKit

class BoxFunctionButtonView: NSButton {
    
    private var callback: (() -> Void)?
    
    init(image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.image = image
        self.bezelStyle = .texturedRounded
        self.target = self
        self.action = #selector(BoxFunction)
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func BoxFunction() {
        callback?()
    }
}
