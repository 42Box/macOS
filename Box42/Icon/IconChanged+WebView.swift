//
//  IconChangedByWebView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import WebKit

// MARK: - WKWebView의 func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)로 Icon을 제어합니다.
extension DisplayURLInToolbar {
    func IconChangedByWebView(_ webView: WKWebView) {
        if webView === WebViewManager.shared.hostingWebView {
            var validate = webView.url?.description.split(separator: "/").map{String($0)}
            if validate?.count ?? 0 < 2 { return }
            let endpoint = validate?.popLast()
            let delimiter = validate?.popLast()
            if delimiter != "board" { return }
            
            icon.menubarStopRunning()
            icon.buttonImageChange(endpoint ?? "fox")
            icon.menubarStartRunning()
            
            print("Icon changed", endpoint)
        }
    }
}
