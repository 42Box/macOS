//
//  BoxViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import AppKit
import WebKit

class BoxViewController: NSViewController {  
    var boxView: BoxBaseContainerViewController = BoxBaseContainerViewController()
    var gradientLayer: CAGradientLayer!
    let preferencesVC = PreferencesViewController()
    weak var menubarVCDelegate: MenubarViewControllerDelegate?
    
    override func loadView() {
        self.view = boxView.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menubarVCDelegate = (NSApplication.shared.delegate as? AppDelegate)?.menubarController
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hex: "#FF9548").cgColor
    }
    
    @objc func boundsDidChange(notification: NSNotification) {
        if let window = notification.object as? NSWindow {
            gradientLayer.frame = window.contentView!.bounds
        }
    }
    
    @objc
    func doubleClickBtn(sender: NSButton) {
        WebViewManager.shared.list[sender.title]!.reload()
    }
    
    @objc
    func pin(_ sender: NSSwitch) {
        StateManager.shared.togglePin()
        print(sender.state)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
    }
}
