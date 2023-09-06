//
//  MemoryView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class MemoryView: NSView {
    
    private let physicalMemoryLabel: NSTextField = NSTextField(labelWithString: "물리적 메모리:")
    private let usedMemoryLabel: NSTextField = NSTextField(labelWithString: "사용된 메모리:")
    private let cachedFilesLabel: NSTextField = NSTextField(labelWithString: "캐시된 파일:")
    private let usedSwapLabel: NSTextField = NSTextField(labelWithString: "사용된 스왑 공간:")
    private let appMemoryLabel: NSTextField = NSTextField(labelWithString: "앱 메모리:")
    private let wiredMemoryLabel: NSTextField = NSTextField(labelWithString: "와이어드 메모리:")
    private let compressedLabel: NSTextField = NSTextField(labelWithString: "압축됨:")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(physicalMemoryLabel)
        addSubview(usedMemoryLabel)
        addSubview(cachedFilesLabel)
        addSubview(usedSwapLabel)
        addSubview(appMemoryLabel)
        addSubview(wiredMemoryLabel)
        addSubview(compressedLabel)
        
        // SnapKit 레이아웃 설정
        physicalMemoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(22)
        }
        
        usedMemoryLabel.snp.makeConstraints { make in
            make.top.equalTo(physicalMemoryLabel.snp.bottom).offset(10)
            make.left.equalTo(physicalMemoryLabel)
        }
        
        cachedFilesLabel.snp.makeConstraints { make in
            make.top.equalTo(usedMemoryLabel.snp.bottom).offset(10)
            make.left.equalTo(physicalMemoryLabel)
        }
        
        usedSwapLabel.snp.makeConstraints { make in
            make.top.equalTo(cachedFilesLabel.snp.bottom).offset(10)
            make.left.equalTo(physicalMemoryLabel)
        }
        
        appMemoryLabel.snp.makeConstraints { make in
            make.top.equalTo(usedSwapLabel.snp.bottom).offset(10)
            make.left.equalTo(physicalMemoryLabel)
        }
        
        wiredMemoryLabel.snp.makeConstraints { make in
            make.top.equalTo(appMemoryLabel.snp.bottom).offset(10)
            make.left.equalTo(physicalMemoryLabel)
        }
        
        compressedLabel.snp.makeConstraints { make in
            make.top.equalTo(wiredMemoryLabel.snp.bottom).offset(10)
            make.left.equalTo(physicalMemoryLabel)
        }
    }
}
