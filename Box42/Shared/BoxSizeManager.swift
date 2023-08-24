//
//  BoxSizeManager.swift
//  Box42
//
//  Created by Chan on 2023/08/11.
//

import Cocoa

struct BoxSizeManager {
    static let shared = BoxSizeManager()
    
    var halfSize: (width: CGFloat, height: CGFloat)!
    var size: (width: CGFloat, height: CGFloat)!
    var buttonGroupSize: (width: CGFloat, height: CGFloat)!
    var toolbarGroupSize: (width: CGFloat, height: CGFloat)!
    var viewStack: [NSView?]
    var boxViewSizeNSRect: NSRect
    var boxViewSizeNSSize: NSSize
    var buttonGroupSizeNSRect: NSRect
    var windowButtonGroupSize: (width: CGFloat, height: CGFloat)!
    
    init() {
        halfSize = (NSScreen.halfOfScreen.x, NSScreen.halfOfScreen.y)
        size = (NSScreen.customScreenSize.width, NSScreen.customScreenSize.height)
        buttonGroupSize = (NSScreen.buttonGroupSize.width, NSScreen.buttonGroupSize.height)
        toolbarGroupSize = (NSScreen.buttonGroupSize.width, CGFloat(100))
        viewStack = [NSView()]
        boxViewSizeNSRect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        boxViewSizeNSSize = NSSize(width: size.width, height: size.height)
        buttonGroupSizeNSRect = NSRect(x: 0, y: 0, width: buttonGroupSize.width, height: buttonGroupSize.height)
        windowButtonGroupSize = (NSScreen.buttonGroupSize.width, NSScreen.customScreenSize.height)
    }
}
