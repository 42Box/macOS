//
//  WebViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa
import WebKit
import Combine

class WebViewController: NSViewController {
	var URLVM = WebViewModel()
    var webView: WKWebView!
    
    // Cancellables array to manage the bindings
    var cancellables: Set<AnyCancellable> = []
    
    override func loadView() {
        self.webView = WebView()
        self.view = webView
        webViewInit()
        loadWebviewInit()
//        bindViewModel()
    }
    
    func loadWebviewInit() {
        URLVM.setUpURLdict()
        loadAllWebview()
    }
    
    func loadWebView(_ name: String, _ url: URL) {
        let wkWebView = WebView()
        WebViewManager.shared.list[name] = wkWebView
        DispatchQueue.main.async {
            wkWebView.load(self.URLVM.requestURL(url))
        }
	}
    
    func loadAllWebview() {
        for (name, URL) in URLVM.URLdict {
            loadWebView(name, URL)
        }
    }
    
    func webViewInit() {
        WebViewManager.shared.hostingWebView = self.webView
        DispatchQueue.main.async {
            self.webView.load(self.URLVM.requestURL(self.URLVM.safeURL()))
        }
    }
    
    func bindViewModel() {
        URLVM.$URLdict
            .sink { [weak self] _ in
                self?.loadAllWebview()
            }
            .store(in: &cancellables)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let url = navigationAction.request.url {
            webView.load(URLRequest(url: url))
        }
        return nil
    }
}
