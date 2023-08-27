//
//  ButtonGroupViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/25/23.
//

import Cocoa

class ButtonGroupViewController: NSViewController {
    override func loadView() {
//        let ButtonViewGroup = BoxButtonViewGroup()
        let ButtonViewGroup = NSView()
        ButtonViewGroup.wantsLayer = true
        ButtonViewGroup.layer?.backgroundColor = NSColor.black.cgColor
        self.view = ButtonViewGroup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func preference() {
        print("preference")
    }
    
    func pin() {
        print("pin")
    }
    
    func quit() {
        print("quit")
        NSApplication.shared.terminate(self)
    }
}
