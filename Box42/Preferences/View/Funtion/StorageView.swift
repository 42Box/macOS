//
//  StorageView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class StorageView: NSView {
    
    var currentStorageTextField: NSTextField = NSTextField()
    var remainingStorageTextField: NSTextField = NSTextField()
    var totalStorageTextField: NSTextField = NSTextField()
    var thresholdTextField: NSTextField = NSTextField()
    var intervalTextField: NSTextField = NSTextField()
    var executeScriptButton: NSButton = NSButton()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // Add subviews
        addSubview(currentStorageTextField)
        addSubview(remainingStorageTextField)
        addSubview(totalStorageTextField)
        addSubview(thresholdTextField)
        addSubview(intervalTextField)
        addSubview(executeScriptButton)
        
        // Initialize UI elements
        initTextFields()
        initButton()
        
        // Set constraints
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTextFields() {
        // Initialize textfields
        let labels = [currentStorageTextField, remainingStorageTextField, totalStorageTextField, thresholdTextField, intervalTextField]
        for label in labels {
            label.font = NSFont.systemFont(ofSize: 14, weight: .semibold)
            label.isEditable = false
            label.isBordered = false
            label.backgroundColor = NSColor.clear
        }
        currentStorageTextField.stringValue = "Current Storage      : ?? GB"
        remainingStorageTextField.stringValue = "Remaining Storage : ?? GB"
        totalStorageTextField.stringValue = "Total Storage            : ?? GB"
        thresholdTextField.placeholderString = "Enter threshold (%)"
        intervalTextField.placeholderString = "Enter interval (seconds)"

        intervalTextField.isEditable = true
        thresholdTextField.isEditable = true
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
        
        thresholdTextField.snp.makeConstraints { make in
            make.top.equalTo(totalStorageTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        intervalTextField.snp.makeConstraints { make in
            make.top.equalTo(thresholdTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        executeScriptButton.snp.makeConstraints { make in
            make.top.equalTo(intervalTextField.snp.bottom).offset(0) // 여기에 20을 추가합니다.
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
    
    @objc func runScript(_ sender: NSButton) {
        // Logic to run script
    }
    
    // Update storage information
    func updateStorageInfo(current: String, remaining: String, total: String) {
        currentStorageTextField.stringValue = "Current Storage: \(current) GB"
        remainingStorageTextField.stringValue = "Remaining Storage: \(remaining) GB"
        totalStorageTextField.stringValue = "Total Storage: \(total) GB"
    }
}
