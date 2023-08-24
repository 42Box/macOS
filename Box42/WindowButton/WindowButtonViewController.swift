//
//  WindowButtonViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import Cocoa

class WindowButtonViewController: NSViewController {
    override func loadView() {
        let windowViewGroup = WindowViewGroup()

        windowViewGroup.close = windowClose
        windowViewGroup.minimize = windowMin
        windowViewGroup.maximize = windowMax
        
        self.view = windowViewGroup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func windowClose() {
        StateManager.shared.showWindow = false
        self.view.window?.close()
    }
    
    func windowMin() {
        StateManager.shared.showWindow = false
        self.view.window?.miniaturize(nil)
    }
    
    func windowMax() {
        self.view.window?.toggleFullScreen(nil)
    }
}
