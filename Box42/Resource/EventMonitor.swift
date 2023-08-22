//
//  EventMonitor.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa

public class EventMonitor {
	private var monitor: Any?
	private let mask: NSEvent.EventTypeMask
	private let handler: (NSEvent?) -> Void
	
	public init(monitor: Any? = nil, mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
		self.mask = mask
		self.handler = handler
	}
	
	deinit {
		stop()
	}
	
	public func start() {
		monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
	}
	
	public func stop() {
		if monitor != nil {
			NSEvent.removeMonitor(monitor!)
			monitor = nil
		}
	}
}
