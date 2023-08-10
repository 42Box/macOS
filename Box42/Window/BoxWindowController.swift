//
//  BoxWindowController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.styleMask.insert(.resizable)

        // BoxViewController 인스턴스를 생성합니다.
        let boxViewController = BoxViewController()
        
        // BoxViewController의 뷰를 윈도우의 콘텐트 뷰로 설정합니다.
        window?.contentViewController = boxViewController
        
        print("boxwindowcont")
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
