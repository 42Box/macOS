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
    var viewStack: [NSView?]
    var boxViewSizeNSRect: NSRect
    var boxViewSizeNSSize: NSSize
    var buttonGroupSizeNSRect: NSRect
    
    init() {
        halfSize = (NSScreen.halfOfScreen.x, NSScreen.halfOfScreen.y)
        size = (NSScreen.customScreenSize.x, NSScreen.customScreenSize.y)
        buttonGroupSize = (CGFloat(132), NSScreen.customScreenSize.y)
        viewStack = [NSView()]
        boxViewSizeNSRect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        boxViewSizeNSSize = NSSize(width: size.width, height: size.height)
        buttonGroupSizeNSRect = NSRect(x: 0, y: 0, width: buttonGroupSize.width, height: buttonGroupSize.height)
    }
}
