//
//  BoxToolbarViewGroup.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit
import SnapKit

class BoxToolbarViewGroup: NSView {
    var toolbarVC: ToolbarViewController?
    
    init() {
//        toolbarVC = ToolbarViewController(nibName: nil, bundle: nil)
        
        super.init(frame: NSRect(x: 0, y: 0, width: BoxSizeManager.shared.size.width - BoxSizeManager.shared.toolbarGroupSize.width, height: BoxSizeManager.shared.toolbarGroupSize.height))
        
        self.wantsLayer = true
//        self.addSubview(toolbarVC!.view)
        
        toolbarVC?.view.translatesAutoresizingMaskIntoConstraints = false
        toolbarVC?.view.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
