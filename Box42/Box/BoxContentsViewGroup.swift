//
//  BoxContentsViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/13/23.
//

import Cocoa
import WebKit

class BoxContentsViewGroup: NSView {
    var webVC: WebViewController?
    var webView: WKWebView!
    
    init() {
        let webVC = WebViewController(nibName: nil, bundle: nil)
        
        super.init(frame: NSRect(x: 0, y: 0, width: BoxSizeManager.shared.size.width - BoxSizeManager.shared.buttonGroupSize.width, height: BoxSizeManager.shared.buttonGroupSize.height))
        
        self.wantsLayer = true
        webVC.view.frame = self.bounds
        self.addSubview(webVC.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
}

