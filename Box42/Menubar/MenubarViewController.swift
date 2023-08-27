//
//  MenubarController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation
import AppKit

class MenubarViewController: NSViewController {
    var popover = NSPopover()
    var statusBarVM = StatusBarViewModel()
    lazy var eventMonitor: EventMonitor = self.setupEventMonitor()
    var boxWindowController: BoxWindowController?
  
    func menubarViewControllerInit() {
        self.buttonInit()
    }
    
    func menubarViewControllerStart() {
        self.menubarStartRunning()
        self.buttonActionInit()
        self.popoverContentViewInit()
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
        buttonImageChange("fox")
        statusBarVM.statusButtonAppear()
    }
    
    func buttonImageChange(_ img: String) {
        statusBarVM.changeStatusBarIcon(img)
    }
    
    func buttonActionInit() {
        statusBarVM.statusBar.statusItem.button?.action = #selector(togglePopover(_:))
        statusBarVM.statusBar.statusItem.button?.target = self
    }
    
    func popoverContentViewInit() {
        let boxViewController = BoxBaseContainerViewController(nibName: nil, bundle: nil)
        popover.contentViewController = boxViewController
    }
    
    func setupEventMonitor() -> EventMonitor {
        return EventMonitor(mask: [.leftMouseDown, .rightMouseDown, .otherMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
                if StateManager.shared.pin == false && event?.buttonNumber != 2 {
                    strongSelf.closePopover(sender: event)
                }
            } else if let strongSelf = self, !strongSelf.popover.isShown {
                if event?.buttonNumber == 2 {
                    strongSelf.popoverHandler(sender: event)
                }
            }
        }
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            popoverHandler(sender: sender)
        }
    }
    
    func popoverHandler(sender: Any?) {
        if let event = sender as? NSEvent {
            if event.type == .otherMouseDown {
                self.toggleWindow(sender: sender)
            }
        } else if let button = statusBarVM.statusBar.statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
}

extension MenubarViewController: MenubarViewControllerDelegate {
    func toggleWindow(sender: Any?) {
        StateManager.shared.toggleShowWindow()
        if StateManager.shared.showWindow == false {
            if let window = boxWindowController?.window {
                if window.isVisible {
                    window.orderOut(sender)
                    print("hide")
                }
            }
        } else {
            if boxWindowController == nil {
                boxWindowController = BoxWindowController(window: nil)
            }
            if let button = statusBarVM.statusBar.statusItem.button,
               let window = boxWindowController?.window {
                if StateManager.shared.showFirstWindow == false {
                    let buttonFrame = button.window?.convertToScreen(button.frame) ?? NSZeroRect
                    let desiredPosition = NSPoint(x: buttonFrame.origin.x - (BoxSizeManager.shared.size.width / 2) - 10, y: buttonFrame.origin.y - window.frame.height)
                    
                    window.setFrameOrigin(desiredPosition)
                    StateManager.shared.toggleShowFirstWindow()
                }
                window.level = .floating
            }
                boxWindowController?.showWindow(sender)
        }
    }
}

protocol MenubarViewControllerDelegate: AnyObject {
    func toggleWindow(sender: Any?)
}
