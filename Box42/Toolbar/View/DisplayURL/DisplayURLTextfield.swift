//
//  DisplayURLTextfield.swift
//  Box42
//
//  Created by Chanhee Kim on 8/25/23.
//

import AppKit

class DisplayURLTextfield: NSTextField {
    var onTextFieldRestore: (() -> Void)?
    
    override var stringValue: String {
        didSet {
            print("TextField Value changed to: \(stringValue)")
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        onTextFieldRestore?()
        super.mouseDown(with: event)
    }
    
    override func keyUp(with event: NSEvent) {
        if event.keyCode == 53 {
            print("url")
            onTextFieldRestore?()
        } else {
            super.keyUp(with: event)
        }
    }
}
