//
//  CPU.swift
//  Run42SeoulPackage2
//
//  Created by Chan on 2023/02/23.
//  Copyright © 2023 Run42. All rights reserved.
//

import Foundation

public class CPU {
	var cpuTimer: Timer? = nil
	var isShow: Bool = false
	var usage: (value: Double, description: String) = (0.0, "")
	
	private let loadInfoCount: mach_msg_type_number_t!
	private var loadPrevious = host_cpu_load_info()
	
	init() {
		loadInfoCount = mach_msg_type_number_t(MemoryLayout<host_cpu_load_info_data_t>.size / MemoryLayout<integer_t>.size)
	}
	
	private func hostCPULoadInfo() -> host_cpu_load_info {
		var size: mach_msg_type_number_t = loadInfoCount
		let hostInfo = host_cpu_load_info_t.allocate(capacity: 1)
		let _ = hostInfo.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
			return host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
		}
		let data = hostInfo.move()
		hostInfo.deallocate()
		return data
	}
	
	public func usageCPU() {
		let load = hostCPULoadInfo()
		let userDiff = Double(load.cpu_ticks.0 - loadPrevious.cpu_ticks.0)
		let sysDiff  = Double(load.cpu_ticks.1 - loadPrevious.cpu_ticks.1)
		let idleDiff = Double(load.cpu_ticks.2 - loadPrevious.cpu_ticks.2)
		let niceDiff = Double(load.cpu_ticks.3 - loadPrevious.cpu_ticks.3)
		loadPrevious = load
		
		let totalTicks = sysDiff + userDiff + idleDiff + niceDiff
		let sys  = 100.0 * sysDiff / totalTicks
		let user = 100.0 * userDiff / totalTicks
		
		let value: Double = round((sys + user) * 10.0) / 10.0
		let description: String = (value >= 100.0) ? "100↑%" : ((value < 10.0 ? " " : "") + String(value)) + "% "
		
		self.usage = (value, description)
	}
	
	public func isShowUsage() -> Bool {
		if isShow == false { return false }
		return true
	}
	
	public func processCPU(_ statusBar: StatusBar) -> Bool {
		cpuTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { _ in
			self.usageCPU()
			statusBar.interval = 0.02 * (100 - max(0.0, min(99.0, self.usage.value))) / 6
			statusBar.statusItem.button?.title = self.isShowUsage() ? self.usage.description : ""
		})
		self.cpuTimer?.fire()
		return true
	}
	
	public func StopCPU() -> Bool {
		self.cpuTimer?.invalidate()
		return false
	}
}
