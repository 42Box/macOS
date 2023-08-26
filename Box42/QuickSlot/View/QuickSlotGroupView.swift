//
//  QuickSlotGroupView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit
import SnapKit

class QuickSlotGroupView: NSView {
    lazy var divider: NSBox = TopDivider(completion: { [weak self] in self?.dividerAction?() })
    lazy var headerView: QuickSlotHeaderView = QuickSlotHeaderView(image: NSImage(imageLiteralResourceName: "star"), completion: { [weak self] in self?.quickslotAction?() })
    lazy var buttonGridView: QuickSlotButtonGridView = QuickSlotButtonGridView(frame: CGRect(x: 0, y: 0, width: 267, height: 134), completion: { [weak self] in self?.buttonAction?() })
    lazy var footerView: QuickSlotHeaderView = QuickSlotHeaderView(image: NSImage(imageLiteralResourceName: "star"), completion: { [weak self] in self?.quickslotAction?() })
    
    var dividerAction: (() -> Void)?
    var quickslotAction: (() -> Void)?
    var buttonAction: (() -> Void)?
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.addSubview(divider)
        self.addSubview(headerView)
        self.addSubview(buttonGridView)
        self.addSubview(footerView)
        
    }

    private func setupConstraints() {
        divider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(QuickSlotUI.size.headerHeight)
        }
        
        buttonGridView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(buttonGridView.snp.bottom).offset(14)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
