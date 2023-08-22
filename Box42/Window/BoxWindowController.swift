//
//  BoxWindowController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxWindowController: NSWindowController, NSToolbarDelegate, NSWindowDelegate {
    override init(window: NSWindow?) {
        let contentRect = BoxSizeManager.shared.boxViewSizeNSRect
        let styleMask: NSWindow.StyleMask = [.resizable, .closable, .miniaturizable, .fullSizeContentView]
        let windowInstance = NSWindow(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)

        windowInstance.titlebarAppearsTransparent = true
        windowInstance.titleVisibility = .hidden
        windowInstance.title = "Box"
        windowInstance.isReleasedWhenClosed = false
        windowInstance.isOpaque = false
        windowInstance.backgroundColor = .clear
        windowInstance.isMovableByWindowBackground = true

        let boxViewController = BoxViewController(nibName: nil, bundle: nil)
        windowInstance.contentViewController = boxViewController

        super.init(window: windowInstance)
        
        windowInstance.delegate = self
        
//        setupToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxWindowController {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
//        NSApplication.shared.terminate(self)
        StateManager.shared.setToggleIsShowWindow()
        return true
    }
}

// MARK: - Toolbar
extension BoxWindowController {
    func setupToolbar() {
        let toolbar = NSToolbar(identifier: "MainToolbar")
        toolbar.delegate = self
        toolbar.displayMode = .iconOnly
        toolbar.sizeMode = .small
        self.window?.toolbar = toolbar
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.group]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.group, .flexibleSpace, .sidebar, .flexibleSpace, .goBack, .flexibleSpace, .goFoward, .flexibleSpace, .reloadPage, .flexibleSpace, .goToHome]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case .group:
            let groupItem = NSToolbarItemGroup(itemIdentifier: .group)
            
            let sidebarItem = NSToolbarItem(itemIdentifier: .sidebar)
            sidebarItem.label = "Sidebar"
            sidebarItem.image = NSImage(named: NSImage.Name("sidebar.leading"))
            sidebarItem.action = #selector(toggleSidebar)
            sidebarItem.minSize = NSSize(width: 40, height: 40)
            sidebarItem.maxSize = NSSize(width: 40, height: 40)
                    
            let goBack = NSToolbarItem(itemIdentifier: .goBack)
            goBack.label = "left"
            goBack.image = NSImage(named: NSImage.Name("arrow.left")) // 이미지 설정
            goBack.action = #selector(goBackAction) // 해당 action 설정
            
            let goFoward = NSToolbarItem(itemIdentifier: .goFoward)
            goFoward.label = "right"
            goFoward.image = NSImage(named: NSImage.Name("arrow.right"))
            goFoward.action = #selector(goFowardAction)
            
            let reloadPage = NSToolbarItem(itemIdentifier: .reloadPage)
            reloadPage.label = "clockwise"
            reloadPage.image = NSImage(named: NSImage.Name("arrow.clockwise"))
            reloadPage.action = #selector(reloadPageAction)
            
            let goToHome = NSToolbarItem(itemIdentifier: .goToHome)
            goToHome.label = "skating"
            goToHome.image = NSImage(named: NSImage.Name("figure.skating"))
            goToHome.action = #selector(goToHomeAction)
            
            groupItem.subitems = [sidebarItem, goBack, goFoward, reloadPage, goToHome]
            
            return groupItem
            
        default:
            return nil
        }
    }
    
    @objc func toggleSidebar() {
        print("sidebar")
    }
    
    @objc func goBackAction() {
        WebViewManager.shared.hostingWebView?.goBack()
    }
    
    @objc func goFowardAction() {
        WebViewManager.shared.hostingWebView?.goForward()
    }
    
    @objc func reloadPageAction() {
        WebViewManager.shared.hostingWebView?.reload()
    }
    
    @objc func goToHomeAction() {
        if let item = WebViewManager.shared.hostingWebView?.backForwardList.backList.first {
            WebViewManager.shared.hostingWebView?.go(to: item)
        }
    }
}

extension NSToolbarItem.Identifier {
    static let sidebar = NSToolbarItem.Identifier(rawValue: "SidebarButton")
    static let goBack = NSToolbarItem.Identifier(rawValue: "goBackButton")
    static let goFoward = NSToolbarItem.Identifier(rawValue: "goFowardButton")
    static let reloadPage = NSToolbarItem.Identifier(rawValue: "reloadPageButton")
    static let goToHome = NSToolbarItem.Identifier(rawValue: "goToHomeButton")
    static let group = NSToolbarItem.Identifier(rawValue: "ItemGroup")
}
