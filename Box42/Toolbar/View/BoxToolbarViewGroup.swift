//
//  BoxToolbarViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit
import SnapKit

class BoxToolbarViewGroup: NSView {
    var displayURL  = DisplayURLInToolbar()
    lazy var sidebarLeading: SideBarLeading = SideBarLeading(image: NSImage(imageLiteralResourceName: "sidebar.leading"), completion: { self.sidebar?() })
    lazy var goBackButton: GoBackInToolbar = GoBackInToolbar(image: NSImage(imageLiteralResourceName: "arrow.left"), completion: { self.goBack?() })
    lazy var goForwardButton: GoForwardInToolbar = GoForwardInToolbar(image: NSImage(imageLiteralResourceName: "arrow.right"), completion: { self.goFoward?()} )
    lazy var reloadPageButton: ReloadPageViaToolbar = ReloadPageViaToolbar(image: NSImage(imageLiteralResourceName: "arrow.clockwise"), completion: { self.reloadPage?() })
    lazy var goHomePageViaButton: GoHomePageViaToolbar = GoHomePageViaToolbar(image: NSImage(imageLiteralResourceName: "figure.skating"), completion: { self.goToHome?() })
    
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
        self.addSubview(displayURL)
        self.addSubview(sidebarLeading)
        self.addSubview(goBackButton)
        self.addSubview(goForwardButton)
        self.addSubview(reloadPageButton)
        self.addSubview(goHomePageViaButton)
    }

    private func setupConstraints() {
        displayURL.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        sidebarLeading.snp.makeConstraints { make in
            make.top.equalTo(displayURL.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(goBackButton)
        }

        goBackButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(sidebarLeading)
            make.left.equalTo(sidebarLeading.snp.right).offset(10)
            make.width.equalTo(goForwardButton)
        }

        goForwardButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(sidebarLeading)
            make.left.equalTo(goBackButton.snp.right).offset(10)
            make.width.equalTo(reloadPageButton)
        }

        reloadPageButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(sidebarLeading)
            make.left.equalTo(goForwardButton.snp.right).offset(10)
            make.width.equalTo(goHomePageViaButton)
        }
        
        goHomePageViaButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(sidebarLeading)
            make.left.equalTo(reloadPageButton.snp.right).offset(10)
            make.right.equalToSuperview()
        }
    }
}
