//
//  ToolbarViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

class ToolbarViewController: NSViewController {
    var displayURL = DisplayURLInToolbar()
    var goBackButton: GoBackInToolbar?
    var goForwardButton: GoForwardInToolbar?
    var reloadPageButton: ReloadPageViaToolbar?
    var goHomePageViaButton: GoHomePageViaToolbar?
    var sidebarLeading: SideBarLeading?
    
    override func loadView() {
        displayURL = DisplayURLInToolbar()
        sidebarLeading = SideBarLeading(image: NSImage(imageLiteralResourceName: "sidebar.leading"), completion: sidebar)
        goBackButton = GoBackInToolbar(image: NSImage(imageLiteralResourceName: "arrow.left"), completion: goBack)
        goForwardButton = GoForwardInToolbar(image: NSImage(imageLiteralResourceName: "arrow.right"), completion: goFoward)
        reloadPageButton = ReloadPageViaToolbar(image: NSImage(imageLiteralResourceName: "arrow.clockwise"), completion: reloadPage)
        goHomePageViaButton = GoHomePageViaToolbar(image: NSImage(imageLiteralResourceName: "figure.skating"), completion: goToHome)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func sidebar() {
        print("sidebar")
    }
    
    func goBack() {
        WebViewList.shared.hostingWebView?.goBack()
    }
    
    func goFoward() {
        WebViewList.shared.hostingWebView?.goForward()
    }
    
    func reloadPage() {
        WebViewList.shared.hostingWebView?.reload()
    }
    
    func goToHome() {
        if let item = WebViewList.shared.hostingWebView?.backForwardList.backList.first {
            WebViewList.shared.hostingWebView?.go(to: item)
        }
    }
}
