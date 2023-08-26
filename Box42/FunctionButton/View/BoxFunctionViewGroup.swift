//
//  BoxFunctionViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import AppKit
import SnapKit

class BoxFunctionViewGroup: NSView {
    lazy var preferenceButton: PreferenceButtonView = PreferenceButtonView(image: NSImage(imageLiteralResourceName: "plus"), completion: { self.preferenceAction?() })
    lazy var pinButton: PinButtonView = PinButtonView(image: NSImage(imageLiteralResourceName: "Pin icon"), completion: { self.pinAction?() })
    lazy var quitButton: QuitButtonView = QuitButtonView(image: NSImage(imageLiteralResourceName: "figure.snowboarding"), completion: { self.quitAction?() })
    lazy var boxButton: BoxFunctionButtonView = BoxFunctionButtonView(image: NSImage(imageLiteralResourceName: "shippingbox"), completion: { self.boxAction?() })
    lazy var divider: NSBox = TopDivider(completion: { self.dividerAction?() })
    
    var preferenceAction: (() -> Void)?
    var pinAction: (() -> Void)?
    var quitAction: (() -> Void)?
    var boxAction: (() -> Void)?
    var dividerAction: (() -> Void)?

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
        self.addSubview(preferenceButton)
        self.addSubview(pinButton)
        self.addSubview(quitButton)
        self.addSubview(boxButton)
        self.addSubview(divider)
    }

    private func setupConstraints() {
        divider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        pinButton.snp.makeConstraints { make in
            make.top.equalTo(divider).offset(10)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(FunctionButtonUI.size.pinWidth)
            make.height.equalTo(FunctionButtonUI.size.pinHeight)
        }

//        preferenceButton.snp.makeConstraints { make in
//            make.top.bottom.equalTo(pinButton)
//            make.left.equalTo(pinButton.snp.right).offset(10)
//            make.width.equalTo(quitButton)
//        }
//
//        quitButton.snp.makeConstraints { make in
//            make.top.bottom.equalTo(pinButton)
//            make.left.equalTo(preferenceButton.snp.right).offset(10)
//            make.width.equalTo(boxButton)
//        }
//
//        boxButton.snp.makeConstraints { make in
//            make.top.bottom.equalTo(pinButton)
//            make.left.equalTo(quitButton.snp.right).offset(10)
//            make.right.equalToSuperview()
//        }
    }
}
