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
    var preferencesVC = PreferencesViewController()
    
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
        guard let currentWebview = WebViewList.shared.list[sender.title] else {
            print("No WebView found for title: \(sender.title)")
            return
        }
        
        currentWebview.frame = self.bounds // WebView의 크기 및 위치 설정
        self.addSubview(currentWebview)
        
        // WebView 설정
        currentWebview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        currentWebview.configuration.preferences.javaScriptEnabled = true
        
        // WebView 내용 로드 확인 (옵셔널)
        if currentWebview.url == nil {
            print("WebView for \(sender.title) has no content loaded.")
        }
        
        currentWebview.viewDidMoveToSuperview()
    }
    
}

