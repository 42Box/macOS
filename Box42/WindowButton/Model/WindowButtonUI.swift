//
//  WindowButtonUI.swift
//  Box42
//
//  Created by Chanhee Kim on 8/25/23.
//

import AppKit

enum WindowButtonUI {
    enum size {
        static let diameter = 15
        static let cornerRadius = CGFloat(diameter / 2)
        static let offset = 8
    }
    
    enum animation {
        static let duration = TimeInterval(0.2)
    }
    
    enum color {
        static let maximize = NSColor(hex: "#76DF7A").cgColor
        static let minimize = NSColor(hex: "#FFCE51").cgColor
        static let close = NSColor(hex: "#F36161").cgColor
        static let opacityWhite = NSColor(hex: "#7FFFFFFF").cgColor
    }
}
