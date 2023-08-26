//
//  WindowViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit
import SnapKit

class WindowViewGroup: NSView {
    lazy var windowClose = WindowCloseButton(completion: { self.close?() })
    lazy var windowMinimize = WindowMinimizeButton(completion: { self.minimize?() })
    lazy var windowMaximize = WindowMaximizeButton(completion: { self.maximize?() })

    var close: (() -> Void)?
    var minimize: (() -> Void)?
    var maximize: (() -> Void)?

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
        self.addSubview(windowClose)
        self.addSubview(windowMinimize)
        self.addSubview(windowMaximize)
    }

    private func setupConstraints() {
        
        windowClose.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(WindowButtonUI.size.diameter)
            make.height.equalTo(WindowButtonUI.size.diameter)
        }

        windowMinimize.snp.makeConstraints { make in
            make.top.bottom.equalTo(windowClose)
            make.left.equalTo(windowClose.snp.right).offset(WindowButtonUI.size.offset)
            make.width.equalTo(WindowButtonUI.size.diameter)
            make.height.equalTo(WindowButtonUI.size.diameter)
        }

        windowMaximize.snp.makeConstraints { make in
            make.top.bottom.equalTo(windowClose)
            make.left.equalTo(windowMinimize.snp.right).offset(WindowButtonUI.size.offset)
            make.width.equalTo(WindowButtonUI.size.diameter)
            make.height.equalTo(WindowButtonUI.size.diameter)
        }
    }
}
