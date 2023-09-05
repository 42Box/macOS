//
//  ShortcutSettingView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class ShortcutSettingView: NSView {
    
    // Create a label for the title
    let titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "앱 내부 단축키 설정")
        label.font = NSFont.systemFont(ofSize: 20, weight: .semibold)
        label.isEditable = false
        label.isSelectable = false
        return label
    }()
    
    // Create an array of labels and text fields for various shortcut settings
    let shortcutSettings: [(label: String, defaultKey: String)] = [
        ("앱 Show 단축키 설정", "Middle Mouse"),
        ("Pin Box 단축키 설정", "^B"),
        ("퀵슬롯 1 설정", "^Q"),
        ("퀵슬롯 2 설정", "^W"),
        ("퀵슬롯 3 설정", "^E"),
        ("퀵슬롯 4 설정", "^R"),
        ("퀵슬롯 5 설정", "^A"),
        ("퀵슬롯 6 설정", "^S"),
        ("퀵슬롯 7 설정", "^D"),
        ("퀵슬롯 8 설정", "^F")
    ]
    
    lazy var stackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        var subStackView: NSStackView?
        
        for (index, (labelText, defaultKey)) in shortcutSettings.enumerated() {
            let label = NSTextField(labelWithString: labelText)
            label.font = NSFont.systemFont(ofSize: 14, weight: .medium)
            label.isEditable = false
            label.isSelectable = false
            let textField = NSTextField()
            textField.placeholderString = defaultKey
            textField.snp.makeConstraints { make in
                make.width.equalTo(50)
            }
            
            if index == 0 || index == 1 {
                let innerStackView = NSStackView(views: [label, textField])
                innerStackView.distribution = .fillProportionally
                stackView.addArrangedSubview(innerStackView)
            } else {
                if index == 2 || index == 6 {
                    subStackView = NSStackView()
                    subStackView?.orientation = .horizontal
                    subStackView?.distribution = .fillEqually
                    subStackView?.spacing = 20
                }
                
                let innerStackView = NSStackView(views: [label, textField])
                innerStackView.distribution = .fillProportionally
                
                subStackView?.addArrangedSubview(innerStackView)
                
                if index == 4 || index == 8 {
                    stackView.addArrangedSubview(subStackView!)
                }
            }
        }
        
        return stackView
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Add titleLabel to the view
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        
        // Add stackView to the view
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
    }
}
