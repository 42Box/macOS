//
//  PinButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import AppKit
import SnapKit

class PinButtonView: NSView {
    
    private var callback: (() -> Void)?
    private let pinBoxButton: NSButton = {
        let button = NSButton()
        return button
    }()
    
    init(title: String, image: NSImage, completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        pinBoxButton.image = image
        pinBoxButton.imagePosition = .imageLeading
        pinBoxButton.image?.alignmentRect = NSRect(x: 0, y: 7, width: 22, height: 22)

        pinBoxButton.target = self
        pinBoxButton.action = #selector(pin)
        
        pinBoxButton.isBordered = false
        pinBoxButton.wantsLayer = true
        pinBoxButton.layer?.backgroundColor = NSColor.clear.cgColor
        
        pinBoxButton.bezelStyle = .inline
        let pinBoxTitle = title

        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: NSFont.systemFont(ofSize: 14.0, weight: .semibold), // 원하는 폰트 및 무게로 설정
            NSAttributedString.Key.foregroundColor: NSColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1),
        ]

        let attributedTitle = NSAttributedString(string: pinBoxTitle, attributes: attributes)

        pinBoxButton.attributedTitle = attributedTitle
        pinBoxButton.attributedAlternateTitle = attributedTitle
    
        self.addSubview(pinBoxButton)
        pinBoxButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(89)
            make.height.equalTo(27)
        }
        
        self.callback = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changePinImage(to image: NSImage) {
        pinBoxButton.image = image
    }
    
    @objc func pin() {
        callback?()
    }
}
