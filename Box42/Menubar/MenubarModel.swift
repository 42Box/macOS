//
//  MenubarModel.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import AppKit

public class StatusBar {
    var statusItem = NSStatusItem()
    var frames = [NSImage]()
    var cnt: Int = 0
    var isRunning: Bool = false
    var interval: Double = 1.0
    var alertCount: Int = 0
}
