//
//  WebViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa
import WebKit
import Combine

class WebViewController: NSViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
	var URLVM = WebViewModel()
    var webView: WKWebView!
    
    // Cancellables array to manage the bindings
    var cancellables: Set<AnyCancellable> = []
    
    override func loadView() {
        self.webView = addWebView()
        self.view = webView
        loadWebViewInit()
        webViewInit()
//        bindViewModel()
    }
    
	func loadWebViewInit() {
        URLVM.setUpURLdict()
        for (key, value) in URLVM.URLdict {
			let wkWebView = addWebView()
			WebViewList.shared.list[key] = wkWebView
			DispatchQueue.main.async {
				wkWebView.load(self.URLVM.requestURL(value))
			}
		}
	}
    
    func webViewInit() {
        DispatchQueue.main.async {
            self.webView.load(self.URLVM.requestURL(self.URLVM.safeURL()))
        }
    }
    
    func bindViewModel() {
        // Whenever URLdict changes, it will call loadWebViewInit
        URLVM.$URLdict
            .sink { [weak self] _ in
                self?.loadWebViewInit()
            }
            .store(in: &cancellables)
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

extension WebViewController {
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        
        if (event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "c") ||
            (event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "ㅊ") {
            // 복사 동작 처리
            webView.evaluateJavaScript("document.execCommand('copy')") { (_, error) in
                if let error = error {
                    print("Copy error: \(error)")
                } else {
                    print("Copy success")
                }
            }
        } else if (event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "v") ||
                    (event.modifierFlags.contains(.command) && event.charactersIgnoringModifiers == "ㅍ") {
            // 붙여넣기 동작 처리
            let pasteboard = NSPasteboard.general
            if let pasteString = pasteboard.string(forType: .string) {
                let escapedPasteString = pasteString.escapedForJavaScript
                webView.evaluateJavaScript("document.execCommand('insertText', false, '\(escapedPasteString)')") { (_, error) in
                    if let error = error {
                        print("Paste error: \(error)")
                    } else {
                        print("Paste success")
                    }
                }
            }
        } else {
            super.keyDown(with: event) // 기본 키 이벤트 처리
        }
    }
}
