//
//  BoxButtonHandler.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxButtonHandler {
    var clickAction: ((NSButton) -> Void)?
    
    @objc func buttonClicked(_ sender: NSButton) {
        clickAction?(sender)
    }
}
