//
//  StorageView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit
import Combine

class StorageView: NSView {
    
    var currentStorageTextField: NSTextField = NSTextField()
    var remainingStorageTextField: NSTextField = NSTextField()
    var totalStorageTextField: NSTextField = NSTextField()
//    var thresholdTextField: NSTextField = NSTextField()
//    var intervalTextField: NSTextField = NSTextField()
    var executeScriptButton: NSButton = NSButton()
    private var subscriptions = Set<AnyCancellable>()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // Add subviews
        addSubview(currentStorageTextField)
        addSubview(remainingStorageTextField)
        addSubview(totalStorageTextField)
//        addSubview(thresholdTextField)
//        addSubview(intervalTextField)
        addSubview(executeScriptButton)
        
        // Initialize UI elements
        initTextFields()
        initButton()
        
        // Set constraints
        setConstraints()
        bindStorageValues()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTextFields() {
        // Initialize textfields
        let labels = [currentStorageTextField, remainingStorageTextField, totalStorageTextField] ///, thresholdTextField, intervalTextField]
        for label in labels {
            label.font = NSFont.systemFont(ofSize: 14, weight: .semibold)
            label.isEditable = false
            label.isBordered = false
            label.backgroundColor = NSColor.clear
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        let usedStorage = formatter.string(from: NSNumber(value: Storage.shared.usedUsage ?? 0)) ?? "0"
        let remainingStorage = formatter.string(from: NSNumber(value: Storage.shared.availableUsage ?? 0)) ?? "0"
        let totalStorage = formatter.string(from: NSNumber(value: Storage.shared.totalUsage ?? 0)) ?? "0"
        
        currentStorageTextField.stringValue = "Current Storage      :  \(usedStorage) GB"
        remainingStorageTextField.stringValue = "Remaining Storage : \(remainingStorage) GB"
        totalStorageTextField.stringValue = "Total Storage            : \(totalStorage) GB"

//        thresholdTextField.placeholderString = "Enter threshold (%)"
//        intervalTextField.placeholderString = "Enter interval (seconds)"
//
//        intervalTextField.isEditable = true
//        thresholdTextField.isEditable = true
    }
    
    func initButton() {
        executeScriptButton.title = "Run Script"
        executeScriptButton.bezelStyle = .inline
        executeScriptButton.wantsLayer = true
        executeScriptButton.layer?.cornerRadius = 15
        executeScriptButton.target = self
        executeScriptButton.action = #selector(runScript(_:))
    }
    
    func setConstraints() {
        // Use SnapKit to set constraints
        currentStorageTextField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
        
        remainingStorageTextField.snp.makeConstraints { make in
            make.top.equalTo(currentStorageTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        totalStorageTextField.snp.makeConstraints { make in
            make.top.equalTo(remainingStorageTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
//        thresholdTextField.snp.makeConstraints { make in
//            make.top.equalTo(totalStorageTextField.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(20)
//            make.height.equalTo(30)
//            make.width.equalTo(100)
//        }
//
//        intervalTextField.snp.makeConstraints { make in
//            make.top.equalTo(thresholdTextField.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(20)
//            make.height.equalTo(30)
//            make.width.equalTo(100)
//        }
        
        executeScriptButton.snp.makeConstraints { make in
            make.top.equalTo(totalStorageTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
    
    @objc func runScript(_ sender: NSButton) {
        StateManager.shared.autoStorage = true
        Storage.shared.storageTimerEvent()
        let notification = NSUserNotification()
        notification.title = "자동화 스크립트를 실행합니다."
        let center = NSUserNotificationCenter.default
        center.deliver(notification)
    }
    
    // Update storage information
    func updateStorageInfo(current: String, remaining: String, total: String) {
        currentStorageTextField.stringValue = "Current Storage: \(current) GB"
        remainingStorageTextField.stringValue = "Remaining Storage: \(remaining) GB"
        totalStorageTextField.stringValue = "Total Storage: \(total) GB"
    }
    
    private func bindStorageValues() {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .decimal
            
            Storage.shared.$usedUsage
                .map { formatter.string(from: NSNumber(value: $0 ?? 0)) ?? "0" }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] value in
                    self?.currentStorageTextField.stringValue = "Current Storage      :  \(value) GB"
                }
                .store(in: &subscriptions)
            
            Storage.shared.$availableUsage
                .map { formatter.string(from: NSNumber(value: $0 ?? 0)) ?? "0" }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] value in
                    self?.remainingStorageTextField.stringValue = "Remaining Storage : \(value) GB"
                }
                .store(in: &subscriptions)
        }
}
