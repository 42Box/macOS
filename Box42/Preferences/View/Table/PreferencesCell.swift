//
//  PreferencesCell.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import Cocoa
import SnapKit

class PreferencesCell: NSTableCellView {
    
    var baseContainerView: NSView = {
        let baseView = NSView()
        baseView.wantsLayer = true
        baseView.layer?.backgroundColor = NSColor.yellow.cgColor
        return baseView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }

    private func setupViews() {
        self.addSubview(baseContainerView)
        baseContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
