//
//  EventMonitor.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa

class EventMonitor {
	private var monitor: Any?
	private let mask: NSEvent.EventTypeMask
	private let handler: (NSEvent?) -> Void
    
	init(monitor: Any? = nil, mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
		self.mask = mask
		self.handler = handler
	}

	deinit {
		stop()
	}
	
	func start() {
        print("EventMonitor: Starting")
		monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
	}
	
	func stop() {
		if monitor != nil {
            print("EventMonitor: Stoping")
			NSEvent.removeMonitor(monitor!)
			monitor = nil
		}
	}
}
