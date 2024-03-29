//
//  ScriptCell.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import AppKit
import SnapKit

class ScriptCell: NSTableCellView {
    var nameLabel: NSTextField = NSTextField()
    var descriptionLabel: NSTextField = NSTextField()
    var excuteButton: ScriptExcuteButton = ScriptExcuteButton()
    var deleteButton: ScriptDeleteButton = ScriptDeleteButton()
    var quickSlotButton: ScriptQuickSlotButton = ScriptQuickSlotButton()
    
    var viewModel: ScriptViewModel?
    var script: Script?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let labels = [nameLabel, descriptionLabel]
        for label in labels {
            label.wantsLayer = true
            label.layer?.cornerRadius = 15
            label.layer?.borderColor = NSColor(red: 0.781, green: 0.781, blue: 0.781, alpha: 1).cgColor
            label.layer?.borderWidth = 1
            
            label.font = NSFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = NSColor.black
        }
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(quickSlotButton)
        addSubview(excuteButton)
        addSubview(deleteButton)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(200).priority(.high) // 최대 너비와 우선순위 설정
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.right.lessThanOrEqualTo(quickSlotButton.snp.left).offset(-8)
            make.width.greaterThanOrEqualTo(100).priority(.low) // 최소 너비와 낮은 우선순위 설정
            make.height.equalTo(30)
        }
        
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(53)
            make.height.equalTo(40)
            
        }
        
        excuteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        
        quickSlotButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(excuteButton.snp.left).offset(-8)
            make.width.equalTo(53)
            make.height.equalTo(40)
        }
    }
    
    
    
    func configure(with script: Script, viewModel: ScriptViewModel?) {
        self.script = script
        self.viewModel = viewModel
        nameLabel.stringValue = script.name
        descriptionLabel.stringValue = script.description ?? "description"
        
        deleteButton.target = self
        deleteButton.action = #selector(deleteButtonClicked)
        
        excuteButton.target = self
        excuteButton.action = #selector(excuteButtonClicked)
        
        quickSlotButton.target = self
        quickSlotButton.action = #selector(quickSlotButtonclicked)
        
    }
    
    @objc func deleteButtonClicked() {
        if let id = script?.scriptUuid {
            viewModel?.deleteScript(id: id)
        }
    }
    
    @objc func excuteButtonClicked() {
        if let path = script?.path {
            viewModel?.excuteScript(path: path)
        }
    }
    
    @objc func quickSlotButtonclicked() {
        guard let path = script?.path else {
            return
        }

        let alreadyExists = QuickSlotViewModel.shared.buttons.contains { $0.path == path }

        if alreadyExists {
            QuickSlotViewModel.shared.removeButton(path)
            quickSlotButton.title = "퀵슬롯"
        } else {
            if QuickSlotViewModel.shared.buttons.count > 7 {
                return
            } else {
                quickSlotButton.title = "저장됨"
//                viewModel?.quickSlotScript(id: id)
                viewModel?.quickSlotScript(path: path)
            }
        }
    }
}
