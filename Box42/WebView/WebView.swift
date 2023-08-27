//
//  WebView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import WebKit

class WebView: WKWebView, WKScriptMessageHandler, WKUIDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("userContentController")
    }
    
    
    init() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true

        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController

        super.init(frame: .zero, configuration: configuration)

        contentController.add(self, name: "box")

        self.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        self.configuration.preferences.javaScriptEnabled = true
        self.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        
        self.uiDelegate = self
        self.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
