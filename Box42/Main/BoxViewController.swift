//
//  BoxViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa
import AppKit
import WebKit

class BoxViewController: NSViewController {  
    var boxView: BoxBaseContainerViewController! = BoxBaseContainerViewController()
    
    let preferencesVC = PreferencesViewController()
    let buttonHandler = BoxButtonHandler()
    weak var menubarVCDelegate: MenubarViewControllerDelegate?
    
    
    override func loadView() {
        self.view = boxView.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menubarVCDelegate = (NSApplication.shared.delegate as? AppDelegate)?.menubarController
    }
    

    @objc
    func doubleClickBtn(sender: NSButton) {
        WebViewList.shared.list[sender.title]!.reload()
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

extension BoxViewController {
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        if event.keyCode == 1 {
            StorageConfig.shared.setThreshold(.percentage50)
            StorageConfig.shared.setPeriod(.period10s)
        }
        if event.keyCode == 2 {
//            SdtorageConfig.shared.setThreshold(.percentage30)
            DispatchQueue.main.async {
                StorageConfig.shared.setThreshold(.percentage30)
            }
            StorageConfig.shared.setPeriod(.period1s)
        }
        
        
        if event.keyCode == 53 { // Escape 키의 keyCode는 53입니다.
            print("escape")
            menubarVCDelegate?.toggleWindow(sender: nil)
        } else {
            super.keyDown(with: event) // 기타 키를 처리하기 위해 상위 클래스에게 전달
        }
    }
}
