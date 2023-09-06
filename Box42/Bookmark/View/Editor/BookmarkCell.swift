//
//  BookmarkCell.swift
//  Box42
//
//  Created by Chanhee Kim on 9/5/23.
//

import AppKit
import SnapKit

class BookmarkCell: NSTableCellView {
    var nameLabel: NSTextField = NSTextField()
    var descriptionLabel: NSTextField = NSTextField()
    var deleteButton: BookmarkDeleteButton = BookmarkDeleteButton()
    var quickSlotButton: BookmarkUpdateButton = BookmarkUpdateButton()
    
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
        addSubview(deleteButton)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(200).priority(.high)
            make.height.equalTo(30)
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
            make.height.equalTo(30)
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
//        NSColor(hex: "#E7E7E7").cgColor
    }
    
    @objc func deleteButtonClicked() {
        if let deleteItem = urlitem {
            BookmarkViewModel.shared.deleteBookmark(item: deleteItem)
        }
    }
    
    @objc func quickSlotButtonclicked() {
        if let tableView = self.superview as? NSTableView {
            let rowIndex = tableView.row(for: self)
            print("현재 셀의 index: \(rowIndex)")
            
            if let updateItem = urlitem {
                print(rowIndex, updateItem)
//                BookmarkViewModel.shared.updateBookmark(rowIndex, item: updateItem)
            }
        }
    }
}
