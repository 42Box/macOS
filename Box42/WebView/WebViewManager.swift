//
//  WebViewList.swift
//  Box42
//
//  Created by Chanhee Kim on 8/17/23.
//

import WebKit

typealias WebViewMapping = [String : WKWebView]

class WebViewManager {
    static let shared = WebViewManager()

    var hostingname: String?
    var hostingWebView: WKWebView?

    var list: WebViewMapping!
    
    private init() {
        list = [:]
    }
}
