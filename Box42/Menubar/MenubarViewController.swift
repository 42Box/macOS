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
    lazy var eventMonitor: EventMonitor = self.setupEventMonitor()
    var statusBarVM: StatusBarViewModel? // 옵셔널로 선언
    let menuBarView = MenuBarView()
    lazy var keyboardEventMonitor = EventMonitor(mask: [.keyDown]) { [weak self] event in
        print("keydown")
    }
    // 초기화 함수나 다른 적절한 시점에 호출
    func initializeStatusBarVM() {
        statusBarVM = StatusBarViewModel(eventMonitor: eventMonitor)
    }
    
    func menubarViewControllerInit() {
        self.initializeStatusBarVM()
        self.buttonInit()
    }
    
    func menubarViewControllerStart() {
        self.menubarStartRunning()
        self.buttonActionInit()
        self.popoverHandler()
    }
    
    func menubarStartRunning() {
        statusBarVM?.startRunning()
    }
    
    func menubarStopRunning() {
        statusBarVM?.stopRunning()
    }
    
	func buttonInit() {
        buttonImageChange("box")
        statusBarVM?.statusButtonAppear()
	}
	
    func buttonImageChange(_ img: String) {
        statusBarVM?.changeStatusBarIcon(img)
    }
    
    func buttonActionInit() {
        statusBarVM?.statusBar.statusItem.button?.action = #selector(togglePopover(_:))
        statusBarVM?.statusBar.statusItem.button?.target = self
    }
    
    func popoverHandler() {
        popover.contentViewController = BoxController.freshController()
    }

    func setupEventMonitor() -> EventMonitor {
        return EventMonitor(mask: [.leftMouseDown, .rightMouseDown, .otherMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
                if StateManager.shared.isPin == false && event?.buttonNumber != 2 {
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
    
    func showPopover(sender: Any?) {
        if let button = statusBarVM?.statusBar.statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor.start()
    }

    func closePopover(sender: Any?) {
        popover.performClose(sender)
//        eventMonitor.stop()
    }
}
