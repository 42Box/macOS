//
//  ScriptCellManager.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import AppKit
import SnapKit

class ScriptCellManager: NSTableCellView {
    var nameLabel: NSTextField = NSTextField()
    var descriptionLabel: NSTextField = NSTextField()
    var deleteButton: ScriptDeleteButton = ScriptDeleteButton()
    var quickSlotButton: ScriptQuickSlotButton = ScriptQuickSlotButton()
    
    var viewModel: BookmarkViewModel?
    var urlitem: URLItem?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(quickSlotButton)
        addSubview(deleteButton)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(200).priority(.high)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(53)
            make.height.equalTo(40)
        }
        
        quickSlotButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            make.width.equalTo(53)
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.right.lessThanOrEqualTo(quickSlotButton.snp.left).offset(-8)
            make.width.greaterThanOrEqualTo(100).priority(.low) // 최소 너비와 낮은 우선순위 설정
        }
    }
    
    
    
    func configure(with urlitem: URLItem, viewModel: BookmarkViewModel?) {
        self.urlitem = urlitem
        self.viewModel = viewModel
        nameLabel.stringValue = urlitem.name
        descriptionLabel.stringValue = urlitem.url
        
        deleteButton.target = self
        deleteButton.action = #selector(deleteButtonClicked)
        
        quickSlotButton.target = self
        quickSlotButton.action = #selector(quickSlotButtonclicked)
        
    }
    
    @objc func deleteButtonClicked() {
//        if let id = script?.scriptUuid {
//            viewModel?.deleteScript(id: id)
//        }
    }
    
    @objc func excuteButtonClicked() {
//        if let path = script?.path {
//            viewModel?.excuteScript(path: path)
//        }
    }
    
    @objc func quickSlotButtonclicked() {
//        guard let path = script?.path else {
//            return
//        }
//
//        let alreadyExists = QuickSlotViewModel.shared.buttons.contains { $0.path == path }
//
//        if alreadyExists {
//            QuickSlotViewModel.shared.removeButton(path)
//            quickSlotButton.title = "퀵슬롯"
//        } else {
//            if QuickSlotViewModel.shared.buttons.count > 7 {
//                return
//            } else {
//                quickSlotButton.title = "저장됨"
////                viewModel?.quickSlotScript(id: id)
//                viewModel?.quickSlotScript(path: path)
//            }
//        }
    }
}
