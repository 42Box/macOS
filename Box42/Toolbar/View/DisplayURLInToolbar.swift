//
//  displayURLInToolbar.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit

class DisplayURLInToolbar: NSTextField {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.isEditable = true
        self.isBordered = false // 테두리를 제거합니다.
        self.backgroundColor = NSColor.clear // 배경색을 투명하게 만듭니다.
        
        if let url = WebViewManager.shared.hostingWebView?.url {
            self.stringValue = url.absoluteString
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateURL() {
        if let url = WebViewManager.shared.hostingWebView?.url {
            self.stringValue = url.absoluteString
        }
    }
}
