//
//  MenubarController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

import AppKit

class MenubarViewController: NSWorkspace {
    var popover = NSPopover()
    var statusBarVM = StatusBarViewModel()
    let menuBarView = MenuBarView()
    lazy var eventMonitor: EventMonitor = self.setupEventMonitor()
    var boxWindowController: BoxWindowController?


    func menubarViewControllerInit() {
        self.buttonInit()
    }
    
    func menubarViewControllerStart() {
        self.menubarStartRunning()
        self.buttonActionInit()
        self.popoverHandler()
        self.startEventMonitoring()
    }
    
    func startEventMonitoring() {
        eventMonitor.start()
    }
    
    func stopEventMonitoring() {
        eventMonitor.stop()
    }
    
    func menubarStartRunning() {
        statusBarVM.startRunning()
    }
    
    func menubarStopRunning() {
        statusBarVM.stopRunning()
    }
    
	func buttonInit() {
        buttonImageChange("Cat")
        statusBarVM.statusButtonAppear()
	}
	
    func buttonImageChange(_ img: String) {
        statusBarVM.changeStatusBarIcon(img)
    }
    
    func buttonActionInit() {
        statusBarVM.statusBar.statusItem.button?.action = #selector(togglePopover(_:))
        statusBarVM.statusBar.statusItem.button?.target = self
    }

    func setupEventMonitor() -> EventMonitor {
        return EventMonitor(mask: [.leftMouseDown, .rightMouseDown, .otherMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
                if StateManager.shared.getIsPin() == false && event?.buttonNumber != 2 {
                    strongSelf.closePopover(sender: event)
                }
            } else if let strongSelf = self, !strongSelf.popover.isShown {
                if event?.buttonNumber == 2 {
                    strongSelf.showPopover(sender: event)
                }
            }
        }
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func popoverHandler() {
        popover.contentViewController = BoxViewController.freshController()
    }
    
    func showPopover(sender: Any?) {
        if let event = sender as? NSEvent {
            if event.type == .otherMouseDown {
                self.showWindow(sender: sender)
            }
        } else if let button = statusBarVM.statusBar.statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func showWindow(sender: Any?) {
        boxWindowController?.close()

        boxWindowController = BoxWindowController(windowNibName: NSNib.Name("BoxWindowController"))

        // status bar 버튼의 위치를 얻어옵니다.
        if let button = statusBarVM.statusBar.statusItem.button,
           let screenFrame = NSScreen.main?.frame,
           let window = boxWindowController?.window {

            let buttonFrame = button.window?.convertToScreen(button.frame) ?? NSZeroRect

            // 버튼 위치 아래에 윈도우를 표시하려면
            let desiredPosition = NSPoint(x: buttonFrame.origin.x, y: buttonFrame.origin.y - window.frame.height)

            // 혹은, 버튼 위치의 중앙에 윈도우를 표시하려면
//             let desiredPosition = NSPoint(x: buttonFrame.midX - window.frame.width / 2, y: buttonFrame.origin.y - window.frame.height)

            // 윈도우의 위치를 설정
            window.setFrameOrigin(desiredPosition)
        }
        boxWindowController?.contentViewController = BoxViewController.freshController()
        boxWindowController?.showWindow(sender)
    }


    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
}
