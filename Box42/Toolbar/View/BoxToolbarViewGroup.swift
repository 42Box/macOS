//
//  BoxToolbarViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit
import SnapKit

class BoxToolbarViewGroup: NSView {
    var displayURL: DisplayURLInToolbar = DisplayURLInToolbar()
    lazy var sidebarLeading: SideBarLeading = SideBarLeading(image: NSImage(imageLiteralResourceName: "toggle-off"), completion: { [weak self] in self?.sidebar?() })
    lazy var goBackButton: GoBackInToolbar = GoBackInToolbar(image: NSImage(imageLiteralResourceName: "arrow-left"), completion: { [weak self] in self?.goBack?() })
    lazy var goForwardButton: GoForwardInToolbar = GoForwardInToolbar(image: NSImage(imageLiteralResourceName: "arrow-right"), completion: { [weak self] in self?.goFoward?()} )
    lazy var reloadPageButton: ReloadPageViaToolbar = ReloadPageViaToolbar(image: NSImage(imageLiteralResourceName: "rotate-right"), completion: { [weak self] in self?.reloadPage?() })
    lazy var goHomePageViaButton: GoHomePageViaToolbar = GoHomePageViaToolbar(image: NSImage(imageLiteralResourceName: "figure.skating"), completion: { [weak self] in self?.goToHome?() })
    
    var goBack: (() -> Void)?
    var goFoward: (() -> Void)?
    var reloadPage: (() -> Void)?
    var goToHome: (() -> Void)?
    var sidebar: (() -> Void)?
    
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
        self.addSubview(goBackButton)
        self.addSubview(goForwardButton)
        self.addSubview(reloadPageButton)
        self.addSubview(sidebarLeading)
        self.addSubview(displayURL)
//        self.addSubview(goHomePageViaButton)
    }

    private func setupConstraints() {
        goBackButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }

        goForwardButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(goBackButton)
            make.left.equalTo(goBackButton.snp.right).offset(14)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }

        reloadPageButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(goBackButton)
            make.left.equalTo(goForwardButton.snp.right).offset(14)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        sidebarLeading.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        displayURL.snp.makeConstraints { make in
            make.top.equalTo(goBackButton.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
