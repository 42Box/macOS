//
//  PreferencesViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 7/24/23.
//

import Cocoa
import SnapKit

class PreferencesViewController: NSViewController {
    var prefTableView : PreferencesTableView?
    
    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
        
        prefTableView = PreferencesTableView(frame: .zero)
        prefTableView?.setup()
//        prefTableView?.viewModel = viewModel
        
        let scrollView = NSScrollView()
        scrollView.documentView = prefTableView
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        prefTableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
}
