//
//  keyDown+AppDelegate.swift
//  Box42
//
//  Created by Chanhee Kim on 8/21/23.
//

import AppKit

extension AppDelegate {
    func eventMonitoring() {
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) { (event) -> NSEvent? in
            print("Key Up: \(event.keyCode)")

            if event.modifierFlags.contains(.control) {
                switch event.keyCode {
                case 12: // 'Q' 키의 keyCode
                    print("Control + Q pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(0)
                case 13: // 'W' 키의 keyCode
                    print("Control + W pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(2)
                case 14: // 'E' 키의 keyCode
                    print("Control + E pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(4)
                case 15: // 'R' 키의 keyCode
                    print("Control + R pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(6)
                case 0:  // 'A' 키의 keyCode
                    print("Control + A pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(1)
                case 1:  // 'S' 키의 keyCode
                    print("Control + S pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(3)
                case 2:  // 'D' 키의 keyCode
                    print("Control + D pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(5)
                case 3:  // 'F' 키의 keyCode
                    print("Control + F pressed")
                    QuickSlotScriptsLogicController.shared.shortCutKeyUP(7)
                case 6:  // 'Z' 키의 keyCode
                    print("Control + Z pressed")
                    StateManager.shared.togglePin() // pin 처리
                case 7:  // 'X' 키의 keyCode
                    print("Control + X pressed")
                default:
                    break
                }
            } else if event.modifierFlags.contains(.command) {
                switch event.keyCode {
                case 12: // 'Q' 키의 keyCode
                    print("command + Q pressed")
                case 13: // 'W' 키의 keyCode
                    print("command + W pressed")
                case 14: // 'E' 키의 keyCode
                    print("command + E pressed")
                case 15: // 'R' 키의 keyCode
                    print("command + R pressed")
                    WebViewManager.shared.hostingWebView?.reload()
                case 0:  // 'A' 키의 keyCode
                    print("command + A pressed")
                case 1:  // 'S' 키의 keyCode
                    print("command + S pressed")
                case 2:  // 'D' 키의 keyCode
                    print("command + D pressed")
                case 3:  // 'F' 키의 keyCode
                    print("command + F pressed")
                default:
                    break
                }
            } else {
                switch event.keyCode {
                case 12: // 'Q' 키의 keyCode
                    print("Q pressed")
                case 13: // 'W' 키의 keyCode
                    print("W pressed")
                case 14: // 'E' 키의 keyCode
                    print("E pressed")
                case 15: // 'R' 키의 keyCode
                    print("R pressed")
                case 0:  // 'A' 키의 keyCode
                    print("A pressed")
                case 1:  // 'S' 키의 keyCode
                    print("S pressed")
                    StorageConfig.shared.setThreshold(.percentage50)
                    StorageConfig.shared.setPeriod(.period10s)
                case 2:  // 'D' 키의 keyCode
                    print("D pressed")
                    DispatchQueue.main.async {
                        StorageConfig.shared.setThreshold(.percentage30)
                    }
                    StorageConfig.shared.setPeriod(.period1s)
                case 3:  // 'F' 키의 keyCode
                    print("F pressed")
                case 53: // Escape 키
                    print("escape")
//                    menubarVCDelegate?.toggleWindow(sender: nil)
                default:
                    break
                }
            }
            return event
        }
    }
}
