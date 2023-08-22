//
//  BoxButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa
import SnapKit

class BoxButtonViewGroup: NSView {
    var boxVM: WebViewModel! = WebViewModel()
    var pinSwitch : NSSwitch = NSSwitch()
    var clickAction: ((NSButton) -> Void)?
    var lastAddedButton: NSView?
    var loginInfo: NSView?
    
    init(clickAction: @escaping (NSButton) -> Void) {
        self.clickAction = clickAction
        super.init(frame: BoxSizeManager.shared.buttonGroupSizeNSRect)
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        // 뷰의 커스텀 렌더링에 사용됨.
    }
    
    private func setupButtons() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }

        for (name, _) in boxVM.webViewURL.URLstring {
            self.createButton(name)
        }
    }
    @objc private func clickBtn(sender: NSButton) {
        clickAction?(sender)
    }
    
    private func createButton(_ title: String) {
        let button: NSButton
        
        if title == "home" {
            button = NSButton(title: "home", image: NSImage(imageLiteralResourceName: "42box_logo"), target: self, action: #selector(clickBtn(sender:)))
            button.imagePosition = .imageOnly
            button.isBordered = false
        } else {
            button = HoverButton()
            button.title = title
            
            button.wantsLayer = true
            button.contentTintColor = NSColor.black
            button.layer?.borderColor = NSColor.black.cgColor
            button.layer?.borderWidth = 1.0
            button.layer?.cornerRadius = 5.0
            button.layer?.opacity = 0.7
        }
        super.addSubview(button)
        
        button.target = self
        button.action = #selector(clickBtn(sender:))
        
        let fontSize: CGFloat = 16.0
        button.font = NSFont.systemFont(ofSize: fontSize)
        button.setButtonType(.momentaryLight)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            
            if title == "home" {
                make.height.equalTo(50)
            } else {
                make.height.equalTo(50)
            }
            
            if let lastButton = lastAddedButton {
                make.top.equalTo(lastButton.snp.bottom).offset(10)
            } else {
                make.top.equalToSuperview().offset(10)
            }
        }
        lastAddedButton = button
    }
}
