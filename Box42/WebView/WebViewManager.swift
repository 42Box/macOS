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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView === _getCookieWebKit {
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                
                let cookieStorage = HTTPCookieStorage.shared
                
                for cookie in cookies {
                    print("\(cookie.name) = \(cookie.value)")
                    cookieStorage.setCookie(cookie)
                }
                
                var request = URLRequest(url: URL(string: "https://api.42box.site/user-service/users/me")!)
                request.httpShouldHandleCookies = true
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received.")
                        return
                    }
                    
                    do {
                        let userProfile = try JSONDecoder().decode(UserProfile.self, from: data)
                        print(userProfile)
                        
                        DispatchQueue.main.sync {
                            self.icon.menubarStopRunning()
                            self.icon.buttonImageChange(userProfile.icon)
                            self.icon.menubarStartRunning()
                        }
                        
                    } catch let jsonError {
                        print("JSON Parsing Error: \(jsonError)")
                    }
                }
                task.resume()
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Did fail navigation with error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Did receive server redirect")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.absoluteString.contains("https://api.42box.site/user-service/users/me") {
            // Handle your own request here and get the response
            print(url)
        }
        decisionHandler(.allow)
    }
}

extension WebViewManager: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "didFinishLoading", let messageBody = message.body as? String {
            print("Received message from JS: \(messageBody)")
            if let url = URL(string: "https://naver.com") {
                let request = URLRequest(url: url)
                hostingWebView?.load(request)
            }
        }
    }
}
