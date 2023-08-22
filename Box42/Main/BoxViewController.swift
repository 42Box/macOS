//
//  BoxViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import AppKit
import WebKit

class BoxViewController: NSViewController {  
    var boxView: BoxBaseContainerViewController! = BoxBaseContainerViewController()
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
        setupGradientLayer()

        NotificationCenter.default.addObserver(self, selector: #selector(boundsDidChange), name: NSWindow.didResizeNotification, object: self.view.window)
    }
    
    func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let startingColor = NSColor(red: 1.0, green: 0.804, blue: 0.0, alpha: 0.9).cgColor
        let endingColor = NSColor(red: 1.0, green: 0.447, blue: 0.0, alpha: 0.7).cgColor
        gradientLayer.colors = [startingColor, endingColor]

        self.view.layer?.addSublayer(gradientLayer)
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
        StateManager.shared.setToggleIsPin()
        print(sender.state)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
    }
}
