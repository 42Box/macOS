//
//  MenubarViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/8/23.
//

import AppKit

class StatusBarViewModel {
    let cpu: CPU
    let eventMonitor: EventMonitor
    let statusBar: StatusBar
    
    init (eventMonitor: EventMonitor) {
        self.statusBar = StatusBar()
        self.cpu = CPU()
        self.eventMonitor = eventMonitor
    }
    
    func statusButtonAppear() {
        statusBar.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    }
    
    func changeStatusBarIcon(_ imgName: String) {
        statusBar.frames.removeAll()
        switch imgName {
        case "cat": for i in (0...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "cat_page\(i)"))}
        case "gon": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gon_\(i)"))}
        case "gun": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gun_\(i)"))}
        case "lee": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gam_\(i)"))}
        case "box": for i in (1...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_\(i)"))}
        case "box_oc": for i in (1...2) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_oc\(i)"))}
        default : for i in (1...11) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42flip_0\(i)"))}
        }
    }
    
    func startRunning() {
        statusBar.isRunning = cpu.processCPU(statusBar)
        self.animate()
    }
    
    func animate() {
        statusBar.statusItem.button?.image = statusBar.frames[statusBar.cnt]
        statusBar.cnt = (statusBar.cnt + 1) % statusBar.frames.count
        if !statusBar.isRunning { return }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + statusBar.interval) {
            self.animate()
        }
    }
    
    func stopRunning() {
        statusBar.isRunning = cpu.StopCPU()
    }
}
