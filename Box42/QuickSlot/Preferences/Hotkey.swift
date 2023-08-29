//
//  Hotkey.swift
//  Box42
//
//  Created by Chanhee Kim on 7/8/23.
//

import Foundation

import Cocoa

func hotkey() {
    let eventMask: CGEventMask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue)
    guard let eventTap = CGEvent.tapCreate(tap: .cghidEventTap, place: .headInsertEventTap, options: .defaultTap, eventsOfInterest: eventMask, callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
        if [.keyDown, .keyUp].contains(type) {
            let flags = event.flags
            let isCommandPressed = flags.contains(.maskCommand)
            let isControlPressed = flags.contains(.maskControl)
            let keyCode = event.getIntegerValueField(.keyboardEventKeycode)

            // keyCode 11 corresponds to the 'b' key
            if isCommandPressed, isControlPressed, keyCode == 11 {
                print("Command + Control + B pressed!")
            }
        }

        return Unmanaged.passRetained(event)
    }, userInfo: nil) else {
        print("Failed to create event tap")
        return
    }

    let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
    CGEvent.tapEnable(tap: eventTap, enable: true)

    CFRunLoopRun()
}
