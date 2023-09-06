//
//  BookmarkCellManager.swift
//  Box42
//
//  Created by Chanhee Kim on 9/5/23.
//

import AppKit
import SnapKit

class BookmarkCellManager: NSTableCellView {
    var nameLabel: NSTextField = NSTextField()
    var descriptionLabel: NSTextField = NSTextField()
    var excuteButton: BookmarkCreateButton = BookmarkCreateButton()
    
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
        addSubview(excuteButton)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(200).priority(.high) // 최대 너비와 우선순위 설정
            make.height.equalTo(30)
        }
        
        excuteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(106 + 8)
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.right.lessThanOrEqualTo(excuteButton.snp.left).offset(-8)
            make.width.greaterThanOrEqualTo(100).priority(.low) // 최소 너비와 낮은 우선순위 설정
            make.height.equalTo(30)
        }
    }
    
    func configure(with urlitem: URLItem, viewModel: BookmarkViewModel?) {
        self.urlitem = urlitem
        self.viewModel = viewModel
        nameLabel.stringValue = urlitem.name
        descriptionLabel.stringValue = urlitem.url
        
        excuteButton.target = self
        excuteButton.action = #selector(excuteButtonClicked)
    }
    
    @objc func excuteButtonClicked() {
        BookmarkViewModel.shared.addBookmark(item: URLItem(name: nameLabel.stringValue, url: descriptionLabel.stringValue))
    }
}
