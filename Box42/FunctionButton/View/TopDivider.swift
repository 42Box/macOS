//
//  TopDivider.swift
//  Box42
//
//  Created by Chanhee Kim on 8/21/23.
//

import AppKit

class TopDivider: NSBox {
    
    private var callback: (() -> Void)?
    
    init(completion: @escaping () -> Void) {
        super.init(frame: .zero)
        self.title = ""
        self.boxType = .separator
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func preference() {
        callback?()
    }
}
