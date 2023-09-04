//
//  BoxContentsViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/13/23.
//

import WebKit
import SnapKit

class BoxContentsViewGroup: NSView, WKUIDelegate {
//        var webVC: WebViewController?
    var preferencesVC = PreferencesViewController()
    var scriptsVC = ScriptsViewController()

    var webView: WKWebView!
    static let shared = BoxContentsViewGroup()
    
    init() {
        super.init(frame: .zero)
//                webVC = WebViewController(nibName: nil, bundle: nil)
        self.wantsLayer = true
        self.layer?.cornerRadius = 20
        self.layer?.masksToBounds = true
        
//        self.addSubview(webVC!.view)
//        webVC?.view.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)

        webView.uiDelegate = self
        WebViewManager.shared.hostingWebView = webView
        self.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }

        if let url = URL(string: "https://www.42box.kr") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        NotificationCenter.default.addObserver(self, selector:
                                                #selector(goBack), name:
                                                Notification.Name("goBack"), object:nil)

        NotificationCenter.default.addObserver(self, selector:
                                                #selector(goForward), name:
                                                Notification.Name("goForward"), object:nil)

        NotificationCenter.default.addObserver(self, selector:
                                                #selector(reload), name:
                                                Notification.Name("reload"), object:nil)
    }

    deinit {
        // view controller가 해제될 때 observer도 제거합니다.
        NotificationCenter.default.removeObserver(self)
    }

    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @objc func reload() {
            webView.reload()
    }
    
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            if let url = navigationAction.request.url {
                if navigationAction.navigationType == .linkActivated {
                    webView.load(URLRequest(url: url))
                    return nil
                }
            }
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, runOpenPanelWith parameters: WKOpenPanelParameters, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping ([URL]?) -> Void) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = parameters.allowsMultipleSelection
        openPanel.level = .popUpMenu
        
        openPanel.begin { (result) in
            if result == .OK {
                completionHandler(openPanel.urls)
            } else {
                completionHandler(nil)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func showPreferences() {
        self.removeAllSubviews()
        self.addSubview(preferencesVC.view)
        preferencesVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showScripts() {
        self.removeAllSubviews()
        self.addSubview(scriptsVC.view)
        scriptsVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showWebviews(_ sender: NSButton) {
        guard let currentWebview = WebViewManager.shared.list[sender.title] else {
            print("No WebView found for title: \(sender.title)")
            return
        }

        WebViewManager.shared.hostingname = sender.title
        WebViewManager.shared.hostingWebView = currentWebview
        
        self.addSubview(currentWebview)
        
        currentWebview.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        if currentWebview.url == nil {
            print("WebView for \(sender.title) has no content loaded.")
        }
        
        currentWebview.viewDidMoveToSuperview()
    }
    
}
