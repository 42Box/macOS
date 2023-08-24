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
    static let screenHeight = screenSize!.height - 60
    static let halfOfScreen = (x: screenWidth / 2, y: screenHeight / 2)
    static let contentsScreenSize = CGSize(width: CGFloat(768), height: screenHeight)
    static let buttonGroupSize = CGSize(width: CGFloat(200), height: screenHeight)
    static let customScreenSize = contentsScreenSize + buttonGroupSize
}

func +(left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height)
}
