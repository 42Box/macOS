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
    
    static var contentsScreenSize = CGSize(width: CGFloat(768).pointsToPixels(), height: screenHeight)
    static let buttonGroupSize = CGSize(width: CGFloat(312).pointsToPixels(), height: screenHeight)
    
    static var customScreenSize: CGSize {
        return contentsScreenSize + buttonGroupSize
    }
}

func +(left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height)
}
