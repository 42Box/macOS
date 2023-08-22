//
//  MenubarController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation

import AppKit

class MenuBarController: NSWorkspace {
	let cpu = CPU()
	let statusBar = StatusBar()
	let menuBarView = MenuBarView()
	
	func buttonInit() {
		menuBarView.imageInit("box", statusBar)
		menuBarView.buttonAppear(statusBar)
	}
	
	func startRunning() {
		statusBar.isRunning = cpu.processCPU(statusBar)
		animate()
	}
	
	func stopRunning() {
		statusBar.isRunning = cpu.StopCPU()
	}
	
	func animate() {
		statusBar.statusItem.button?.image = statusBar.frames[statusBar.cnt]
		statusBar.cnt = (statusBar.cnt + 1) % statusBar.frames.count
		if !statusBar.isRunning { return }
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + statusBar.interval) {
			self.animate()
		}
	}
}
