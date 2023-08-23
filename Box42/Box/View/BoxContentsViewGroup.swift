//
//  BoxContentsViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/13/23.
//

import WebKit
import SnapKit

class BoxContentsViewGroup: NSView {
    var webVC: WebViewController?
    var preferencesVC = PreferencesViewController()
    
    init() {
        webVC = WebViewController(nibName: nil, bundle: nil)
        
        super.init(frame: NSRect(x: 0, y: 0, width: BoxSizeManager.shared.size.width - BoxSizeManager.shared.buttonGroupSize.width, height: BoxSizeManager.shared.buttonGroupSize.height))
        
        self.frame.size.width = BoxSizeManager.shared.size.width - BoxSizeManager.shared.buttonGroupSize.width
        self.frame.size.height = BoxSizeManager.shared.size.height
        
        self.wantsLayer = true
        self.addSubview(webVC!.view)

        webVC?.view.translatesAutoresizingMaskIntoConstraints = false
        webVC?.view.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func showPreferences() {
        self.addSubview(preferencesVC.view)
        preferencesVC.viewDidAppear()
    }
    
    func showWebviews(_ sender: NSButton) {
        guard let currentWebview = WebViewManager.shared.list[sender.title] else {
            print("No WebView found for title: \(sender.title)")
            return
        }

        WebViewManager.shared.hostingname = sender.title
        WebViewManager.shared.hostingWebView = currentWebview
        
        self.addSubview(currentWebview)
        
        currentWebview.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        if currentWebview.url == nil {
            print("WebView for \(sender.title) has no content loaded.")
        }
        
        currentWebview.viewDidMoveToSuperview()
        currentWebview.becomeFirstResponder()
    }
    
}
