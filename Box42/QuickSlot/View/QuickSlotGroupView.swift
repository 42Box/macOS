//
//  QuickSlotGroupView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit
import SnapKit

class QuickSlotGroupView: NSView {
    lazy var divider: NSBox = TopDivider(completion: { self.dividerAction?() })
    lazy var headerView: QuickSlotHeaderView = QuickSlotHeaderView(image: NSImage(imageLiteralResourceName: "star"), completion: { self.quickslotAction?() })
    
    var dividerAction: (() -> Void)?
    var quickslotAction: (() -> Void)?
    
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
    }
}
