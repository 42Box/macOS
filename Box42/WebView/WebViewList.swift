//
//  WebViewList.swift
//  Box42
//
//  Created by Chanhee Kim on 8/17/23.
//

import WebKit

typealias WebViewMapping = [String : WKWebView]

class WebViewList {
    static let shared = WebViewList()

    var hostingname: String?
    var hostingWebView: WKWebView?

    var list: WebViewMapping!
    
    private init() {
        list = [:]
    }
}
