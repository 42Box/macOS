//
//  CPUView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class CPUView: NSView {

    // UI Elements
    private let usageLabel: NSTextField = {
        let label = NSTextField(labelWithString: "Usage: ")
        label.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let systemLabel: NSTextField = {
        let label = NSTextField(labelWithString: "System: ")
        label.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let userLabel: NSTextField = {
        let label = NSTextField(labelWithString: "User: ")
        label.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let idleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "Idle: ")
        label.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    // Initialize view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // Setup UI elements
    private func setupViews() {
        addSubview(usageLabel)
        addSubview(systemLabel)
        addSubview(userLabel)
        addSubview(idleLabel)
        
        usageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        systemLabel.snp.makeConstraints { make in
            make.top.equalTo(usageLabel.snp.bottom).offset(16)
            make.leading.equalTo(usageLabel.snp.leading)
        }
        
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(systemLabel.snp.bottom).offset(16)
            make.leading.equalTo(systemLabel.snp.leading)
        }
        
        idleLabel.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(16)
            make.leading.equalTo(userLabel.snp.leading)
        }
    }

    // Update data
    func updateData(usage: String, system: String, user: String, idle: String) {
        usageLabel.stringValue = "Usage: \(usage)"
        systemLabel.stringValue = "System: \(system)"
        userLabel.stringValue = "User: \(user)"
        idleLabel.stringValue = "Idle: \(idle)"
    }
}
