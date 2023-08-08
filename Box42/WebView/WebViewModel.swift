//
//  WebViewModel.swift
//  Box42
//
//  Created by Chan on 2023/03/19.
//

import WebKit

// Singleton
class WebViewList {
	static let shared = WebViewList()

	var list: [String : WKWebView]!
	
	private init() {
		list = [:]
	}
}
