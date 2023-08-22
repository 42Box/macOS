//
//  NSScreen.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

extension NSScreen {
    static let screenSize = NSScreen.main?.visibleFrame.size
    static let screenWidth = screenSize!.width
    static let screenHeight = screenSize!.height
    static let halfOfScreen = (x: screenWidth / 2, y: screenHeight / 2)
    static let customScreenSize = (x: CGFloat(900), y: screenHeight - 132)
}
