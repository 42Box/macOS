//
//  BookmarkEditorView.swift
//  Box42
//
//  Created by Dasol on 2023/09/04.
//

import Cocoa

class BookmarkRowView: NSView {
    let nameField = NSTextField()
    let urlField = NSTextField()
    
    init(bookmark: URLItem) {
        super.init(frame: .zero)
        
        nameField.stringValue = bookmark.name
        urlField.stringValue = bookmark.url
        
        addSubview(nameField)
        addSubview(urlField)
        
        nameField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        urlField.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(nameField.snp.trailing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BookmarkEditorView : NSView {
    
    var bookMarkList : [URLItem]
    var changeButton=NSButton(title:"Change",target:nil,action:nil)
    var closeButton=NSButton(title:"Close",target:nil,action:nil)
    
    init(bookMarkList : [URLItem]){
        
        self.bookMarkList=bookMarkList
        
        super.init(frame:.zero)
        
        for (name, url) in bookMarkList.enumerated(){
            let row=BookmarkRowView(bookmark: url)
            self.addSubview(row)
            
            row.snp.makeConstraints { make in
                if name == 0 {
                    // First row should be at the top of the editor.
                    make.top.equalToSuperview()
                } else {
                    // Other rows should be below the previous one.
                    make.top.equalTo(self.subviews[name - 1].snp.bottom)
                }
                
                // All rows have the same height and span the entire width of the editor.
                make.height.equalTo(44)  // Or any other height you want.
                make.left.right.equalToSuperview()
            }
        }
        
        self.addSubview(changeButton)
        
        changeButton.snp.makeConstraints {make in
            if let lastSubview=self.subviews.last{
                // Place it under last subview
                make.top.equalTo(lastSubview.snp.bottom).offset(10)
            }else{
                make.top.equalToSuperview()
            }
            
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(closeButton)
        closeButton.target = self
        closeButton.action = #selector(closeButtonClicked(_:))
        closeButton.snp.makeConstraints{maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(changeButton.snp.bottom).offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonClicked(_ sender:NSButton) {
        removeFromSuperview()
    }
}



