//
//  WindowViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/23/23.
//

import AppKit
import SnapKit

class WindowViewGroup: NSView {
    lazy var windowClose: WindowCloseButton = WindowCloseButton(image: NSImage(imageLiteralResourceName: "sidebar.leading"), completion: { self.close?() })
    lazy var windowMinimize: WindowMinimizeButton = WindowMinimizeButton(image: NSImage(imageLiteralResourceName: "arrow.left"), completion: { self.minimize?()} )
    lazy var windowMaximize: WindowMaximizeButton = WindowMaximizeButton(image: NSImage(imageLiteralResourceName: "arrow.right"), completion: { self.maximize?() })

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
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(windowMinimize)
        }

        windowMinimize.snp.makeConstraints { make in
            make.top.bottom.equalTo(windowClose)
            make.left.equalTo(windowClose.snp.right).offset(10)
            make.width.equalTo(windowMaximize)
        }

        windowMaximize.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(windowMinimize.snp.right).offset(10)
        }
    }
}
