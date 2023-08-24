//
//  MenubarViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/8/23.
//

import AppKit

class StatusBarViewModel {
    let cpu: CPU
    let statusBar: StatusBar
    private var currentAnimationWorkItem: DispatchWorkItem?
    
    init () {
        self.statusBar = StatusBar.shared
        self.cpu = CPU()
    }
    
    func statusButtonAppear() {
        statusBar.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    }
    
    func changeStatusBarIcon(_ imgName: String) {
        statusBar.frames.removeAll()
        
        switch imgName {
        case "Cat": for i in (0...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "cat_page\(i)"))}
        case "gon": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gon_\(i)"))}
        case "gun": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gun_\(i)"))}
        case "gam": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gam_\(i)"))}
        case "lee": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "lee_\(i)"))}
        case "Box": for i in (1...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_\(i)"))}
        case "Fox": for i in (1...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "fox_page\(i)"))}
        case "box_oc": for i in (1...2) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_oc\(i)"))}
        default : for i in (1...11) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42flip_0\(i)"))}
        }
    }
    
    func startRunning() {
        statusBar.isRunning = cpu.processCPU(statusBar)
        scheduleAnimation()
    }
    
    func animate() {
        statusBar.statusItem.button?.image = statusBar.frames[statusBar.cnt]
        statusBar.cnt = (statusBar.cnt + 1) % statusBar.frames.count
        if !statusBar.isRunning { return }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + statusBar.interval) {
            self.animate()
        }
    }
    
    func scheduleAnimation() {
        currentAnimationWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            self?.statusBar.statusItem.button?.image = self?.statusBar.frames[self?.statusBar.cnt ?? 0]
            self?.statusBar.cnt = ((self?.statusBar.cnt)! + 1) % (self?.statusBar.frames.count ?? 1)
            
            if self?.statusBar.isRunning ?? false {
                self?.scheduleAnimation()
            }
        }

        currentAnimationWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + statusBar.interval, execute: workItem)
    }
    
    func stopRunning() {
        statusBar.isRunning = cpu.StopCPU()
        currentAnimationWorkItem?.cancel()
        statusBar.cnt = 0
    }
}
