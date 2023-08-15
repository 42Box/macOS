//
//  Storage.swift
//  Box42
//
//  Created by Chanhee Kim on 8/16/23.
//

import Foundation
import Combine

class Storage {
    var storageTimer: Timer? = nil
    var usage: (value: Double, description:String) = (0.0, "")
    var count = 0
    let gibiByte = Double(1 << 30)
    var config: StorageConfig

    private var subscriptions = Set<AnyCancellable>()
    
    private var availableUsage: Double?
    private var usedUsage: Double?
    private var totalUsage: Double?
        
    init(config: StorageConfig = StorageConfig.shared) {
        self.config = config
        
        config.$threshold.sink { [weak self] newThreshold in
            self?.storageTimerEvent()
        }.store(in: &subscriptions)
        
        config.$period.sink { [weak self] newPeriod in
            self?.storageTimerEvent()
        }.store(in: &subscriptions)
    }
    
    func checkStorage() -> Bool {
        do {
            let fileSystemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            if let freeSpace = fileSystemAttributes[.systemFreeSize] as? NSNumber {
                availableUsage = freeSpace.doubleValue / gibiByte
            }
            if let totalSpace = fileSystemAttributes[.systemSize] as? NSNumber {
                totalUsage = totalSpace.doubleValue / gibiByte
            }
            if totalUsage != nil && availableUsage != nil {
                usedUsage = totalUsage! - availableUsage!
            }
        } catch {
            print("Error obtaining system storage info: \(error)")
            return true
        }
        return false
    }
    
    func storageTimerEvent(){
        storageTimer?.invalidate()
        storageTimer = Timer.scheduledTimer(withTimeInterval: config.period.rawValue, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            if self.checkStorage() {
                print("FileSystem정보를 가져오는데 실패 하였습니다.")
                return
            }
            
            if let usedUsage = self.usedUsage, let totalUsage = self.totalUsage, totalUsage != 0 {
                let usagePercentage = usedUsage / totalUsage
                if usagePercentage < self.config.threshold.rawValue {
                    self.cleanSh()
                    self.count += 1
                    print(self.count > 5 ? "캐시 문제가 아닙니다. ncdu ~ 를 확인해주세요." : "\(usedUsage.roundedToTwoDecimalPlaces) GB", "Storage used is less than 30%")
                } else {
                    self.count = 0
                }
            } else {
                print("Failed to get storage usage details")
            }
        })
        storageTimer?.fire()
    }
    
    func cleanSh() {
        if let scriptPath = Bundle.main.path(forResource: "cleanCache", ofType: "sh") {
            let task = Process()
            task.launchPath = "/bin/sh"
            task.arguments = [scriptPath]
            
            task.launch()
            task.waitUntilExit()

            // 실행되었다는 것을 알려주고 싶으면 파이프 뽑아서 하면됨.
        } else {
            print("Script not found")
        }
    }
    
    func change() {
        config.setThreshold(.percentage30)
        config.setPeriod(.period10s)
    }
}
