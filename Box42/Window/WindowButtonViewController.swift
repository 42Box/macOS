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
        print("close")
    }
    
    func windowMin() {
        print("min")
    }
    
    func windowMax() {
        print("max")
    }
}
