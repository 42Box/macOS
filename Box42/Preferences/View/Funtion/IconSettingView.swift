//
//  IconSettingView.swift
//  Box42
//
//  Created by Your Name on 8/31/23.
//

import AppKit
import SnapKit

class CustomSwitch: NSButton {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setButtonType(.pushOnPushOff)
        self.title = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if self.state == .on {
            // On 상태일 때의 색상 및 디자인 설정
            NSColor.green.setFill()
            dirtyRect.fill()
        } else {
            // Off 상태일 때의 색상 및 디자인 설정
            NSColor.red.setFill()
            dirtyRect.fill()
        }
    }
}

class IconSettingView: NSView {
    private let iconSettingLabel: NSTextField = {
        let label = NSTextField(labelWithString: "아이콘 설정")
        label.font = NSFont.systemFont(ofSize: 20)
        label.isEditable = false
        label.isSelectable = false
        return label
    }()
    
    private let flipLabel: NSTextField = {
        let label = NSTextField(labelWithString: "아이콘 좌우반전")
        return label
    }()
    
    private let flipSwitch: NSSwitch = {
        let flipSwitch = NSSwitch()
//        flipSwitch.wantsLayer = true
//        flipSwitch.layer?.backgroundColor = NSColor(hex: "#FF9548").cgColor

        return flipSwitch
    }()
    
    private let speedUpLabel: NSTextField = {
        let label = NSTextField(labelWithString: "CPU가 느릴때 더 빠르게")
        return label
    }()
    
    private let speedUpSwitch: CustomSwitch = {
        let speedUpSwitch = CustomSwitch()
        return speedUpSwitch
        
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(iconSettingLabel)
        self.addSubview(flipLabel)
        self.addSubview(flipSwitch)
        self.addSubview(speedUpLabel)
        self.addSubview(speedUpSwitch)
        
        iconSettingLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        flipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconSettingLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
        }
        
        flipSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(flipLabel)
            make.left.equalTo(flipLabel.snp.right).offset(10)
        }
        
        speedUpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(flipLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
        }
        
        speedUpSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(speedUpLabel)
            make.left.equalTo(speedUpLabel.snp.right).offset(10)
        }
    }
}
