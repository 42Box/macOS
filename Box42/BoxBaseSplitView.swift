//
//  BoxBaseSplitView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/19/23.
//

import AppKit

class BoxBaseSplitView: NSSplitView {
    init() {
        super.init(frame: .zero)

        self.isVertical = true
        self.dividerStyle = .thin
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
