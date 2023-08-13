//
//  BoxButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxButtonViewGroup: NSView {
    var boxVM: WebViewModel! = WebViewModel()
    var divider : NSBox = NSBox()
    var pinSwitch : NSSwitch = NSSwitch()
    var clickAction: ((NSButton) -> Void)?
    var lastAddedButton: NSView?
    
    init(clickAction: @escaping (NSButton) -> Void) {
        self.clickAction = clickAction
        super.init(frame: BoxSizeManager.shared.buttonGroupSizeNSRect)

//        self.wantsLayer = true
        setupButtons()
        divide()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        // 뷰의 커스텀 렌더링에 사용됨.
    }
    
    override func layout() {
        //        layout(): 뷰의 서브뷰들이 리사이징될 때 호출됩니다. 레이아웃을 조정하는 데 사용됩니다.
    }
    
    private func setupButtons() {
        createHomeButton()
        for (name, _) in boxVM.webViewURL.URLstring {
            self.createButton(name)
        }
        preferencesButton()
        createQuitButton()
        createPinButton()
    }
    
    @objc private func clickBtn(sender: NSButton) {
        clickAction?(sender) // 클로저 실행
    }
    
    private func createButton(_ title: String) {
        let button = NSButton()
        
        button.title = title
        button.setButtonType(.momentaryLight)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.target = self
        button.action = #selector(clickBtn(sender:))
        
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        super.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            // 이전 버튼의 bottom anchor와 연결
            button.topAnchor.constraint(equalTo: lastAddedButton?.bottomAnchor ?? self.topAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        lastAddedButton = button
    }
    
//    func createHomeButton() {
//        let button = NSButton(title: "home", image: NSImage(imageLiteralResourceName: "42box_logo"), target: self, action: #selector(clickBtn(sender:)))
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isBordered = false
//        button.imagePosition = .imageOnly
//
//        super.addSubview(button)
//
//        NSLayoutConstraint.activate([
//            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            // 이전 버튼의 bottom anchor와 연결
//            button.topAnchor.constraint(equalTo: lastAddedButton?.bottomAnchor ?? self.topAnchor, constant: 10),
//            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            button.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
//        lastAddedButton = button
//    }
    
    func createHomeButton() {
        let button = NSButton(title: "home", image: NSImage(imageLiteralResourceName: "42box_logo"), target: self, action: #selector(clickBtn(sender:)))
        super.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isBordered = false
        button.imagePosition = .imageOnly

    
//        NSLayoutConstraint.activate([
//            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
////            button.heightAnchor.constraint(equalToConstant: 30)
//        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20), // 좌측 간격을 100에서 20으로 변경
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20), // 우측 간격을 80에서 20으로 변경
            button.heightAnchor.constraint(equalToConstant: 30)
        ])

        lastAddedButton = nil // home 버튼 이후의 버튼들이 상단에 연결되지 않도록 설정
    }


    
//    func createQuitButton() {
//        let button = NSButton()
//        button.title = "Quit Box"
//        button.setButtonType(.momentaryLight)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.action =  #selector(NSApplication.terminate(_:))
//        button.isBordered = true
//        button.bezelStyle = .roundRect
//        button.showsBorderOnlyWhileMouseInside = true
//
//        self.addSubview(button)
//
//        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
//        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
//    }
    
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

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            button.topAnchor.constraint(equalTo: lastAddedButton?.bottomAnchor ?? self.topAnchor, constant: 10), // 이 부분 수정
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])

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
