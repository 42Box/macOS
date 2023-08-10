//
//  BoxViewModel.swift
//  Box42
//
//  Created by Chan on 2023/08/11.
//

import Cocoa

struct BoxViewSize {
    var halfSize: (width: CGFloat, height: CGFloat)!
    var size: (width: CGFloat, height: CGFloat)!
    var buttonGroupSize: (width: CGFloat, height: CGFloat)!
    var viewStack: [NSView?]
    
    init() {
        halfSize = (NSScreen.halfOfScreen.x, NSScreen.halfOfScreen.y)
        size = (NSScreen.customScreenSize.x, NSScreen.customScreenSize.y)
        buttonGroupSize = (CGFloat(132), NSScreen.customScreenSize.y)
        viewStack = [NSView()]
    }
}
