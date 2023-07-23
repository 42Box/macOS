//
//  WebViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa
import WebKit

class WebViewController: NSViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    func loadWebViewInit() {
        for i in 0..<URLModel().URLstring.count {
            let wkWebView = addWebView()
            WebViewList.shared.list[URLModel().URLstring[i].0] = wkWebView
            let rqURL = URLRequest(url: URLModel().URLdict[URLModel().URLstring[i].0]!)
            DispatchQueue.main.async {
                wkWebView.load(rqURL)
            }
        }
    }
    
    func addWebView() -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "box")
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView.configuration.preferences.javaScriptEnabled = true
        
        webView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        if #available(macOS 11.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        }
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
    }
}
