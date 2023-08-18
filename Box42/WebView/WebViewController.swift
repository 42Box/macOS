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
        WebViewList.shared.list[name] = wkWebView
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
