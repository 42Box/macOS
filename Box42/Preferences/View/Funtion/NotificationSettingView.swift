//
//  NotificationSettingView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class NotificationSettingView: NSView {
    
    // Create a label for the title
    let titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "Box 알림 설정")
        label.font = NSFont.systemFont(ofSize: 20)
        label.isEditable = false
        label.isSelectable = false
        return label
    }()
    
    // Create a switch button
    let toggleButton: NSButton = {
        let toggle = NSButton(checkboxWithTitle: "알림 활성화", target: nil, action: #selector(toggleChanged))
        return toggle
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    private func setupViews() {
        // Add titleLabel to the view
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
        }
        
        // Add toggleButton to the view
        addSubview(toggleButton)
        toggleButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        
        toggleButton.target = self
        toggleButton.action = #selector(toggleChanged)
    }
    
    @objc private func toggleChanged(_ sender: NSButton) {
        print("Notification is now \(sender.state == .on ? "enabled" : "disabled")")
    }
}
