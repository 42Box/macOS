//
//  ToolbarViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

class ToolbarViewController: NSViewController {
//    var displayURL = DisplayURLInToolbar()
//    var goBackButton: GoBackInToolbar?
//    var goForwardButton: GoForwardInToolbar?
//    var reloadPageButton: ReloadPageViaToolbar?
//    var goHomePageViaButton: GoHomePageViaToolbar?
//    var sidebarLeading: SideBarLeading?
//
    override func loadView() {
//        displayURL = DisplayURLInToolbar()
//        sidebarLeading = SideBarLeading(image: NSImage(imageLiteralResourceName: "sidebar.leading"), completion: sidebar)
//        goBackButton = GoBackInToolbar(image: NSImage(imageLiteralResourceName: "arrow.left"), completion: goBack)
//        goForwardButton = GoForwardInToolbar(image: NSImage(imageLiteralResourceName: "arrow.right"), completion: goFoward)
//        reloadPageButton = ReloadPageViaToolbar(image: NSImage(imageLiteralResourceName: "arrow.clockwise"), completion: reloadPage)
//        goHomePageViaButton = GoHomePageViaToolbar(image: NSImage(imageLiteralResourceName: "figure.skating"), completion: goToHome)

        let toolbarViewGroup = BoxToolbarViewGroup()
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
