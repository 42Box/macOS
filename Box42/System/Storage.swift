//
//  Storage.swift
//  Box42
//
//  Created by Chanhee Kim on 8/16/23.
//

import Cocoa
import Combine

class Storage {
    static let shared = Storage()
    
    var storageTimer: Timer? = nil
    var usage: (value: Double, description:String) = (0.0, "")
    var count = 0
    let gibiByte = Double(1 << 30)
    var config: StorageConfig

    private var subscriptions = Set<AnyCancellable>()
    
    @Published var availableUsage: Double?
    @Published var usedUsage: Double?
    var totalUsage: Double?
        
    private init(config: StorageConfig = StorageConfig.shared) {
        self.config = config
        
        config.$threshold.sink { [weak self] newThreshold in
            self?.storageTimerEvent()
        }.store(in: &subscriptions)
        
        config.$period.sink { [weak self] newPeriod in
            self?.storageTimerEvent()
        }.store(in: &subscriptions)
        
        _ = checkStorage()
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
        
        if StateManager.shared.autoStorage == false {
            return
        }
        
        storageTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            if self.checkStorage() {
                print("FileSystem정보를 가져오는데 실패 하였습니다.")
                return
            }
            
            if let usedUsage = self.usedUsage, let totalUsage = self.totalUsage, totalUsage != 0 {
                let remain = (totalUsage - usedUsage)
//                let usagePercentage = (totalUsage - usedUsage) / totalUsage
//                if usagePercentage < self.config.threshold.rawValue {
                if remain < 0.3 {
                    self.autoCleanSh()
                    
                    let notification = NSUserNotification()
                    notification.title = "자동 클린 캐시가 실행 되었습니다."
                    let center = NSUserNotificationCenter.default
                    center.deliver(notification)
                    
                    self.count += 1
                    if self.count > 1 {
//                        showMessageWithAppleScript("캐시 문제가 아닙니다. ncdu ~ 를 확인해주세요.", "재시작") { button in
//                            print("timer")
//                            dump(button)
//                            if let button = button {
//                                switch button {
//                                case "재시작":
//                                    StateManager.shared.setOnIsAutoStorage()
//                                    print("재시작 버튼을 클릭했습니다.")
//                                case "취소":
//                                    // 취소 관련 로직 실행
//                                    print("취소 버튼을 클릭했습니다.")
//                                default:
//                                    break
//                                }
//                            }
//                        }
                        let notification = NSUserNotification()
                        notification.title = "캐시 문제가 아닙니다. \n 용량을 확인해주세요."
                        let center = NSUserNotificationCenter.default
                        center.deliver(notification)
                        
                        StateManager.shared.setOffAutoStorage()
                        self.storageTimer?.invalidate()
                    } else {
                        print("\(usedUsage.roundedToTwoDecimalPlaces) GB", "Storage used is less than 30%")
                    }
                } else {
                    self.count = 0
                }
                
            } else {
                print("Failed to get storage usage details")
            }
        })
        
        storageTimer?.fire()
    }

    
    func autoCleanSh() {
        if let scriptPath = Bundle.main.path(forResource: "CleanCache_cluster", ofType: "sh") {
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
    
    func runScriptAndDisplayOutput() {
        // 새로운 윈도우 생성
        let newWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 500, height: 300), styleMask: [.titled, .closable], backing: .buffered, defer: false)
        newWindow.title = "Script Output"
        
        let outputTextField = NSTextField(frame: NSRect(x: 20, y: 20, width: 460, height: 260))
        outputTextField.isEditable = false
        outputTextField.isBordered = true
        newWindow.contentView?.addSubview(outputTextField)
        
        newWindow.makeKeyAndOrderFront(nil)
        
        // 스크립트 실행 및 결과 출력
        if let scriptPath = Bundle.main.path(forResource: "CleanCache_cluster", ofType: "sh") {
            let task = Process()
            task.launchPath = "/bin/sh"
            task.arguments = [scriptPath]
            
            let pipe = Pipe()
            task.standardOutput = pipe
            task.launch()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                outputTextField.stringValue = output
            }
            
            task.waitUntilExit()
        } else {
            print("Script not found")
        }
    }

    
    func change() {
        config.setThreshold(.percentage30)
        config.setPeriod(.period10s)
    }
}
