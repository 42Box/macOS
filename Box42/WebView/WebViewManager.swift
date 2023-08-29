//
//  WebViewList.swift
//  Box42
//
//  Created by Chanhee Kim on 8/17/23.
//

import WebKit

typealias WebViewMapping = [String : WKWebView]

class WebViewManager: NSObject {
    static let shared = WebViewManager()
    
    var icon = MenubarViewController()
    
    private var _getCookieWebKit: WKWebView?
    
    var hostingname: String?
    var hostingWebView: WKWebView? {
        didSet {
            hostingWebView?.navigationDelegate = self
            print("didSet")
        }
    }
    
    var list: WebViewMapping!
    
    private override init() {
        super.init()
        
        list = [:]
        
        let webConfiguration = WKWebViewConfiguration()
        _getCookieWebKit = WKWebView(frame: .zero, configuration: webConfiguration)
        _getCookieWebKit?.navigationDelegate = self
        _getCookieWebKit?.isHidden = true
    }
    
    func getCookie() {
        if let url = URL(string: "https://api.42box.site") {
            let request = URLRequest(url: url)
            _getCookieWebKit?.load(request)
        }
    }
}

extension WebViewManager: WKNavigationDelegate {
    // WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Did start navigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Did fail navigation with error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Did receive server redirect")
    }
}
