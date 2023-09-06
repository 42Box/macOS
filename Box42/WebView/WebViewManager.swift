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
    
    var getCookieWebKit: WKWebView {
        didSet {
            getCookieWebKit.navigationDelegate = self
            getCookieWebKit.isHidden = true
            print(getCookie)
        }
    }
    
    var hostingname: String?
    var hostingWebView: WKWebView? {
        didSet {
            hostingWebView?.navigationDelegate = self

            DisplayURLInToolbar.shared.updateURL()
            print("hosting View didSet")
        }
    }
    
    var list: WebViewMapping!
    
    private override init() {
        list = [:]
        
        let webConfiguration = WKWebViewConfiguration()
        getCookieWebKit = WKWebView(frame: .zero, configuration: webConfiguration)
    }
    
    func getCookie() {
        if let url = URL(string: "https://api.42box.kr") {
            let request = URLRequest(url: url)
            getCookieWebKit.load(request)
        }
    }
    
    func storageSetCookie() {
        getCookieWebKit.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            let cookieStorage = HTTPCookieStorage.shared
            for cookie in cookies {
                cookieStorage.setCookie(cookie)
            }
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
