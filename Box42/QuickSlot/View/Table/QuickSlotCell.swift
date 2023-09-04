//
//  QuickSlotCell.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import AppKit
import SnapKit

class QuickSlotCell: NSTableCellView {
    var imageButton: NSButton = NSButton()
    var titleLabel: NSTextField = NSTextField()
    var pathLabel: NSTextField = NSTextField()
    var typeLabel: NSTextField = NSTextField()
    var deleteButton: QuickSlotCellDeleteButton = QuickSlotCellDeleteButton()
    
    var viewModel: QuickSlotViewModel?
    var qsButton: QuickSlotButtonModel?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageButton)
        addSubview(titleLabel)
        addSubview(pathLabel)
        addSubview(typeLabel)
        addSubview(deleteButton)
        
        imageButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(imageButton.snp.height).multipliedBy(1)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageButton.snp.right).offset(8)
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            make.top.equalTo(imageButton)
        }
        
        pathLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(pathLabel)
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            make.top.equalTo(pathLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(with qsItem: QuickSlotButtonModel, viewModel: QuickSlotViewModel?) {
        self.qsButton = qsItem
        self.viewModel = viewModel
        titleLabel.stringValue = qsItem.title
        pathLabel.stringValue = qsItem.path ?? "none"

        if qsItem.title == "CleanCache" {
            imageButton.image = NSImage(imageLiteralResourceName: "trash")
        } else if qsItem.type == "sh" {
            imageButton.image = NSImage(imageLiteralResourceName: "document-text")
        } else if qsItem.type == "pref" {
            imageButton.image = NSImage(imageLiteralResourceName: "setting")
        } else if qsItem.type == "default-sh" {
            imageButton.image = NSImage(imageLiteralResourceName: "document-text")
        } else if qsItem.type == "default-pref" {
            imageButton.image = NSImage(imageLiteralResourceName: "setting")
        }
        imageButton.isBordered = false
        
        
        deleteButton.target = self
        deleteButton.action = #selector(deleteButtonClicked)
    }
    
    @objc func deleteButtonClicked() {
        //        if let id = qsButton?.scriptUuid {
        //            viewModel?.removeButton(id)
        //        }
        if let path = qsButton?.path {
            viewModel?.removeButton(path)
        }
    }
}
