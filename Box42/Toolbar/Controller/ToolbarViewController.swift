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
    
//    func runPrefsHelperApplication() {
//        let prefsHelperAppPath = "/Users/daskim/Downloads/prefsHelper.app" // prefsHelper.app의 경로
//
//        let appURL = URL(fileURLWithPath: prefsHelperAppPath)
//
//        let workspace = NSWorkspace.shared
//        do {
//            try workspace.open([appURL], withAppBundleIdentifier: nil, options: [], additionalEventParamDescriptor: nil, launchIdentifiers: nil)
//        } catch {
//            print("Error opening app: \(error)")
//        }
//    }
    
    func sidebar() {
        print("sidebar")
        BookmarkViewModel.shared.addBookmark(item: URLItem(name: "chan", url: "https://www.naver.com"))
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
