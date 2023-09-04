//
//  QuickSlotGroupView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit
import SnapKit

class QuickSlotGroupView: NSView {
    
    lazy var divider: NSBox = Divider(completion: { [weak self] in self?.dividerAction?() })
    lazy var headerView: QuickSlotHeaderView = QuickSlotHeaderView(image: NSImage(imageLiteralResourceName: "Star"), completion: { [weak self] in self?.headerAction?() })
    lazy var buttonCollectionView: QuickSlotButtonCollectionViewController = QuickSlotButtonCollectionViewController()
    
    var dividerAction: (() -> Void)?
    var headerAction: (() -> Void)?
    
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
        self.addSubview(buttonCollectionView.view)
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
        
        buttonCollectionView.view.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(14)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
