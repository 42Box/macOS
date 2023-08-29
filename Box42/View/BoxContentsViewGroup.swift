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
    var scriptsVC = ScriptsViewController()
    
    init() {
        super.init(frame: .zero)
        webVC = WebViewController(nibName: nil, bundle: nil)
        self.wantsLayer = true
        self.layer?.cornerRadius = 20
        self.layer?.masksToBounds = true
        self.addSubview(webVC!.view)
        webVC?.view.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func showPreferences() {
        self.removeAllSubviews()
        self.addSubview(preferencesVC.view)
        preferencesVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showScripts() {
        self.removeAllSubviews()
        self.addSubview(scriptsVC.view)
        scriptsVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    }
    
}
