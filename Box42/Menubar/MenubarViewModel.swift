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
    private let scheduleQueue = DispatchQueue(label: "animation.scheduleQueue")
    
    init () {
        self.statusBar = StatusBar.shared
        self.cpu = CPU()
    }
    
    func statusButtonAppear() {
        statusBar.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    }
    
    func changeStatusBarIcon(_ imgName: String) {
        statusBar.frames.removeAll()
        currentAnimationWorkItem?.cancel()
        if statusBar.version == Int.max {
            statusBar.version = 0
        } else {
            statusBar.version += 1
        }

        switch imgName {
        case "cat": for i in (0...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "cat_page\(i)"))}
        case "gon": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gon_\(i)"))}
        case "gun": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gun_\(i)"))}
        case "gam": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gam_\(i)"))}
        case "lee": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "lee_\(i)"))}
        case "box": for i in (1...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_\(i)"))}
        case "fox": for i in (1...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "fox_page\(i)"))}
        case "sitting_fox": for i in (0...3) {statusBar.frames.append(NSImage(imageLiteralResourceName: "sitting_fox\(i)"))}
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
        scheduleQueue.sync {
            currentAnimationWorkItem?.cancel()
            
            let currentVersion = statusBar.version

            let workItem = DispatchWorkItem { [weak self] in
                guard self?.statusBar.version == currentVersion else { return }
                
                self?.statusBar.statusItem.button?.image = self?.statusBar.frames[self?.statusBar.cnt ?? 0]
                
                if let cnt = self?.statusBar.cnt, let framesCount = self?.statusBar.frames.count {
                    self?.statusBar.cnt = (cnt + 1) % framesCount
                }
                
                if self?.statusBar.isRunning ?? false {
                    self?.scheduleAnimation()
                }
            }
            
            currentAnimationWorkItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + statusBar.interval, execute: workItem)
        }
    }

    func stopRunning() {
        statusBar.isRunning = cpu.stopCPU()
        currentAnimationWorkItem?.cancel()
        statusBar.cnt = 0
    }
}
