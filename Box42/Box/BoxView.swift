//
//  BoxView.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa

class BoxView: NSView {
	
}

struct BoxViewSize {
    var halfSize: (width: CGFloat, height: CGFloat) = (NSScreen.halfOfScreen.x, NSScreen.halfOfScreen.y)
    var size: (width: CGFloat, height: CGFloat) = (NSScreen.customScreenSize.x, NSScreen.customScreenSize.y)
    var buttonGroupSize: (width: CGFloat, height: CGFloat) = (CGFloat(132), NSScreen.customScreenSize.y)
    var viewStack = [NSView()]
}

extension NSScreen {
    static let screenSize = NSScreen.main?.visibleFrame.size
    static let screenWidth = screenSize!.width
    static let screenHeight = screenSize!.height
    static let halfOfScreen = (x: screenWidth / 2, y: screenHeight / 2)
    static let customScreenSize = (x: CGFloat(900), y: screenHeight - 132)
}
