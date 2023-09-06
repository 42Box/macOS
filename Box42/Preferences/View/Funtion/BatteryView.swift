//
//  BatteryView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class BatteryView: NSView {
    
    private let currentStateLabel: NSTextField = NSTextField(labelWithString: "현재 상태 (%):")
    private let powerSourceLabel: NSTextField = NSTextField(labelWithString: "Power Source:")
    private let maxCapacityLabel: NSTextField = NSTextField(labelWithString: "Max Capacity:")
    private let cycleCountLabel: NSTextField = NSTextField(labelWithString: "Cycle Count:")
    private let temperatureLabel: NSTextField = NSTextField(labelWithString: "Temperature:")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(currentStateLabel)
        addSubview(powerSourceLabel)
        addSubview(maxCapacityLabel)
        addSubview(cycleCountLabel)
        addSubview(temperatureLabel)
        
        // SnapKit 레이아웃 설정
        currentStateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(22)
        }
        
        powerSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(currentStateLabel.snp.bottom).offset(10)
            make.left.equalTo(currentStateLabel)
        }
        
        maxCapacityLabel.snp.makeConstraints { make in
            make.top.equalTo(powerSourceLabel.snp.bottom).offset(10)
            make.left.equalTo(currentStateLabel)
        }
        
        cycleCountLabel.snp.makeConstraints { make in
            make.top.equalTo(maxCapacityLabel.snp.bottom).offset(10)
            make.left.equalTo(currentStateLabel)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cycleCountLabel.snp.bottom).offset(10)
            make.left.equalTo(currentStateLabel)
        }
    }
}
