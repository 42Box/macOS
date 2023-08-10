//
//  BoxView.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa

class BoxView: NSView {
    var buttonBoxGroup : NSView!
    var buttonViewGroup : NSView!
    var hostingViewGroup : NSView!
    var divider : NSBox!
    var pinSwitch : NSSwitch!
    var boxModel = BoxViewSize()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
        viewInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        viewInit()
    }

    private func commonInit() {
        buttonBoxGroup = NSView()
        buttonViewGroup = NSView()
        hostingViewGroup = NSView()
        divider = NSBox()
        pinSwitch = NSSwitch()

        // Pan Gesture Recognizer를 추가합니다.
        let panRecognizer = NSPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panRecognizer)
    }

    func viewInit() {
        self.boxViewSizeInit()
        self.buttonBoxGroupInit()
        self.divide()
    }
    
    func boxViewSizeInit() {
        self.frame.size.width = boxModel.size.width
        self.frame.size.height = boxModel.size.height
        
        hostingViewGroup.frame.size.width = boxModel.size.width - boxModel.buttonGroupSize.width
        hostingViewGroup.frame.size.height = boxModel.size.height
        
        buttonViewGroup.frame.size.width = boxModel.buttonGroupSize.width
        buttonViewGroup.frame.size.height = boxModel.buttonGroupSize.height
    }
    
    func divide() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: buttonBoxGroup.bottomAnchor, constant: -40).isActive = true
    }

    func buttonBoxGroupInit() {
        self.buttonBoxGroup = NSView(frame: NSRect(x: 0, y: 0, width: boxModel.buttonGroupSize.width, height: boxModel.buttonGroupSize.height))
        self.buttonBoxGroup.frame.size.width = boxModel.buttonGroupSize.width
        self.buttonBoxGroup.frame.size.height = boxModel.buttonGroupSize.height
        self.buttonViewGroup.addSubview(self.buttonBoxGroup)
        
        setAutoLayout(from: self.buttonBoxGroup, to: self.buttonViewGroup)
    }
    
    func setAutoLayout(from: NSView, to: NSView) {
        from.translatesAutoresizingMaskIntoConstraints = false
        to.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: from, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .top, relatedBy: .equal, toItem: to, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .bottom, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        self.layout()
    }
}

extension BoxView {
    @objc private func handlePanGesture(_ recognizer: NSPanGestureRecognizer) {
        guard let view = recognizer.view else { return }

        // 사용자가 드래그한 변화량을 가져옵니다.
        let translation = recognizer.translation(in: view)

        // 드래그로 인한 크기 변화를 계산합니다.
        let newWidth = view.frame.width + translation.x
        let newHeight = view.frame.height + translation.y

        // 크기를 적용합니다.
        view.setFrameSize(NSSize(width: newWidth, height: newHeight))

        // 변화량을 리셋합니다.
        recognizer.setTranslation(.zero, in: view)
    }
}
