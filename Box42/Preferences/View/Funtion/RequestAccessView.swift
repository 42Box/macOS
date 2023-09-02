//
//  RequestAccessView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

class RequestAccessView: NSView {
    private let requestAccessLabel: NSTextField = {
        let label = NSTextField(labelWithString: "Request Access")
        label.font = NSFont.systemFont(ofSize: 20)
        label.isEditable = false
        label.isSelectable = false
        return label
    }()
    var requestAccessTextField: NSTextField = NSTextField()
    var grantAccessButton: NSButton = NSButton()
    var revokeAccessButton: NSButton = NSButton()
    var directoryNameTextField: NSTextField = NSTextField()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: .zero)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hex: "#7FFFFFFF").cgColor
        self.layer?.cornerRadius = 13

        // Add subviews
        self.addSubview(requestAccessLabel)
        self.addSubview(requestAccessTextField)
        self.addSubview(grantAccessButton)
        self.addSubview(revokeAccessButton)
        self.addSubview(directoryNameTextField)
        
        // Initialize UI elements
        textfieldInit()
        buttonInit()
        directoryNameTextFieldInit()
        
        // Set constraints
        textfieldConstraints()
        buttonConstraints()
        directoryNameTextFieldConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textfieldInit() {
        requestAccessTextField.stringValue = "Script 및 기능들을 실행하기 위해서 루트 디렉토리의 권한이 필요합니다."
        requestAccessTextField.font = NSFont.systemFont(ofSize: 15)
        requestAccessTextField.isEditable = false
        requestAccessTextField.isBordered = false
        requestAccessTextField.backgroundColor = NSColor.clear
        requestAccessTextField.lineBreakMode = .byWordWrapping
        requestAccessTextField.maximumNumberOfLines = 3
    }
    
    func buttonInit() {
        grantAccessButton.title = "권한 부여"
        grantAccessButton.target = self
        grantAccessButton.action = #selector(requestFolderAccess(_:))
        
        revokeAccessButton.title = "권한 취소"
        revokeAccessButton.target = self
        revokeAccessButton.action = #selector(revokeFolderAccess(_:))
    }
    
    func directoryNameTextFieldInit() {
        directoryNameTextField.stringValue = "선택된 디렉터리: 없음"
        directoryNameTextField.font = NSFont.systemFont(ofSize: 15)
        directoryNameTextField.isEditable = false
        directoryNameTextField.isBordered = false
        directoryNameTextField.backgroundColor = NSColor.clear
        directoryNameTextField.lineBreakMode = .byWordWrapping
    }
    
    func directoryNameTextFieldConstraints() {
        directoryNameTextField.snp.makeConstraints { make in
            make.top.equalTo(revokeAccessButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
        }
    }
    
     func textfieldConstraints() {
        requestAccessLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
        }
        
         requestAccessTextField.snp.makeConstraints { make in
            make.top.equalTo(requestAccessLabel.snp.bottom).offset(10)
             make.leading.equalToSuperview().offset(17)
             make.trailing.equalToSuperview().offset(-17)
         }
     }
     
     func buttonConstraints() {
         grantAccessButton.snp.makeConstraints { make in
             make.top.equalTo(requestAccessTextField.snp.bottom).offset(10)
             make.leading.equalToSuperview().offset(17)
         }
         
         revokeAccessButton.snp.makeConstraints { make in
             make.top.equalTo(requestAccessTextField.snp.bottom).offset(10)
             make.leading.equalTo(grantAccessButton.snp.trailing).offset(10)
         }
     }
    
    @objc func requestFolderAccess(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.title = "Choose a folder"
        openPanel.showsResizeIndicator = true
        openPanel.showsHiddenFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseFiles = false
        
        if openPanel.runModal() == NSApplication.ModalResponse.OK {
            let result = openPanel.url
            
            if let result = result {
                print("Selected folder is \(result.path)")
                
                directoryNameTextField.stringValue = "선택된 디렉터리: \(result.path)"

                do {
                    let bookmarkData = try result.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
                    UserDefaults.standard.set(bookmarkData, forKey: "bookmarkData")
                } catch {
                    print("Error creating bookmark: \(error)")
                }
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @objc func revokeFolderAccess(_ sender: NSButton) {
        // TODO: Add code to revoke folder access
    }
    
}
