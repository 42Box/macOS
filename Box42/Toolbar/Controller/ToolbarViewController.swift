//
//  ToolbarViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

class ToolbarViewController: NSViewController {
    override func loadView() {
        let toolbarViewGroup = BoxToolbarViewGroup()
        
        toolbarViewGroup.sidebar = sidebar
        toolbarViewGroup.goBack = goBack
        toolbarViewGroup.goFoward = goFoward
        toolbarViewGroup.reloadPage = reloadPage
        toolbarViewGroup.goToHome = goToHome
        
        self.view = toolbarViewGroup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func sidebar() {
        print("sidebar")
    }
    
    func goBack() {
        WebViewManager.shared.hostingWebView?.goBack()
    }
    
    func goFoward() {
        WebViewManager.shared.hostingWebView?.goForward()
    }
    
    func reloadPage() {
        WebViewManager.shared.hostingWebView?.reload()
    }
    
    func goToHome() {
        if let item = WebViewManager.shared.hostingWebView?.backForwardList.backList.first {
            WebViewManager.shared.hostingWebView?.go(to: item)
        }
    }
}
