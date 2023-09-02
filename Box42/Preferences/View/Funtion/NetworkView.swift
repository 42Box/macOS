//
//  NetworkView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class NetworkView: NSView {
    
    private let connectionTypeLabel: NSTextField = NSTextField(labelWithString: "Connection Type:")
    private let localIPLabel: NSTextField = NSTextField(labelWithString: "Local IP:")
    private let uploadLabel: NSTextField = NSTextField(labelWithString: "Upload:")
    private let downloadLabel: NSTextField = NSTextField(labelWithString: "Download:")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(connectionTypeLabel)
        addSubview(localIPLabel)
        addSubview(uploadLabel)
        addSubview(downloadLabel)
        
        // SnapKit을 이용한 레이아웃 설정
        connectionTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        localIPLabel.snp.makeConstraints { make in
            make.top.equalTo(connectionTypeLabel.snp.bottom).offset(10)
            make.left.equalTo(connectionTypeLabel)
        }
        
        uploadLabel.snp.makeConstraints { make in
            make.top.equalTo(localIPLabel.snp.bottom).offset(10)
            make.left.equalTo(connectionTypeLabel)
        }
        
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(uploadLabel.snp.bottom).offset(10)
            make.left.equalTo(connectionTypeLabel)
        }
    }
}
