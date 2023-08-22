//
//  MenubarModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import AppKit

class StatusBar {
    static let shared = StatusBar()
    
    var statusItem: NSStatusItem
    var frames: [NSImage]
	var cnt: Int
	var isRunning: Bool
	var interval: Double
	var alertCount: Int

    init() {
        self.statusItem = NSStatusItem()
        self.frames = [NSImage]()
        self.cnt = 0
        self.isRunning = false
        self.interval = 1.0
        self.alertCount = 0
    }
}
