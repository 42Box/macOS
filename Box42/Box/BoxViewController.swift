//
//  BoxViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa
import AppKit
import WebKit

class BoxViewController: NSViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    var boxView: BoxButtonView!
    var boxVM: BoxViewModel!
    var wvc = WebViewController()
    let preferencesVC = PreferencesViewController()
    
    private var webView: WKWebView!
    
    override func loadView() {
        boxView = BoxButtonView()
        boxVM = BoxViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.window?.styleMask.insert(.resizable)
        view.window?.makeFirstResponder(self)
        
        webViewInit()
        wvc.loadWebViewInit()
        configureButton()
    }

    @objc
    func doubleClickBtn(sender: NSButton) {
        WebViewList.shared.list[sender.title]!.reload()
    }
    
    @objc
    func clickBtn(sender: NSButton) {
        guard let clickCount = NSApp.currentEvent?.clickCount else { return }
        if sender.title == "Preferences" {
            boxView.hostingViewGroup.subviews.removeAll()
            boxView.hostingViewGroup.addSubview(preferencesVC.view)
            preferencesVC.viewDidAppear()
            setAutoLayout(from: preferencesVC.view, to: boxView.hostingViewGroup)
            return
        }
        if clickCount == 2 {
            WebViewList.shared.list[sender.title]!.reload()
            print("Dobule Click")
        } else if clickCount > 2 {
            let rqURL = URLRequest(url: boxVM.URLdict[sender.title]!)
            WebViewList.shared.list[sender.title]!.load(rqURL)
            print("Triple Click")
        } else if clickCount < 2 {
            boxView.hostingViewGroup.subviews.removeAll()
            boxView.hostingViewGroup.addSubview(WebViewList.shared.list[sender.title]!)
            WebViewList.shared.list[sender.title]!.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
            WebViewList.shared.list[sender.title]!.configuration.preferences.javaScriptEnabled = true
            WebViewList.shared.list[sender.title]?.viewDidMoveToSuperview()
            setAutoLayout(from: WebViewList.shared.list[sender.title]!, to: boxView.hostingViewGroup)
        }
    }
    
    @objc
    func pin(_ sender: NSSwitch) {
        StateManager.shared.setToggleIsPin()
        print(sender.state)
    }
    
    func webViewInit() {
        boxVM.setUpURLdict()
        webView = wvc.addWebView()
        boxView.hostingViewGroup.addSubview(webView)
        setAutoLayout(from: webView, to: boxView.hostingViewGroup)
        let request = URLRequest(url: boxVM.URLdict["home"]!)
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
    
    public func setAutoLayout(from: NSView, to: NSView) {
        from.translatesAutoresizingMaskIntoConstraints = false
        to.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: from, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .top, relatedBy: .equal, toItem: to, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .bottom, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        view.layout()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
    }
    
    func configureButton() {
        boxView.createHomeButton(clickAction: clickBtn)
        for (name, _) in boxVM.webViewURL.URLstring {
            boxView.createButton(name, clickAction: clickBtn)
        }
        boxView.divide()
        boxView.preferencesButton(clickAction: clickBtn)
        boxView.createQuitButton()
        boxView.createPinButton(clickAction: clickBtn)
    }
}

extension BoxViewController {
    static func freshController() -> BoxViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("Main")

        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? BoxViewController else {
            fatalError("Story Board Not Found")
        }
        return viewcontroller
    }
}

extension BoxViewController {
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        if event.keyCode == 53 { // Escape 키의 keyCode는 53입니다.
            print("escape")
        } else {
            super.keyDown(with: event) // 기타 키를 처리하기 위해 상위 클래스에게 전달
        }
        
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
