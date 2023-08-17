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
    var divider : NSBox = NSBox()
    var pinSwitch : NSSwitch = NSSwitch()
    var clickAction: ((NSButton) -> Void)?
    var lastAddedButton: NSView?
    var loginInfo: NSView?
    
    init(clickAction: @escaping (NSButton) -> Void) {
        self.clickAction = clickAction
        super.init(frame: BoxSizeManager.shared.buttonGroupSizeNSRect)
        setupButtons()
        divide()
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
        createLoginInfo()
        preferencesButton()
        createQuitButton()
        createPinButton()
    }
    
    func createLoginInfo() {
        
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


    func createQuitButton() {
        let button = NSButton()
        button.title = "Quit Box"
        button.setButtonType(.momentaryLight)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.action = #selector(NSApplication.terminate(_:))
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true

        self.addSubview(button)

        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }

        lastAddedButton = button // 이 부분 추가
    }
    
    func createPinButton() {
        let button = NSButton()
        button.title = "Pin Box"
        button.setButtonType(.toggle)
        button.contentTintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.target = self
        button.action = #selector(clickBtn(sender:))
        
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        self.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    func preferencesButton() {
        let button = NSButton()
        button.title = "Preferences"
        button.setButtonType(.momentaryLight)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.target = self
        button.action = #selector(clickBtn(sender:))
        
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        self.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }

    func divide() {
        divider.boxType = .separator
        divider.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
}
