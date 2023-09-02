//
//  ScriptsViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import Cocoa
import Foundation

class ScriptsViewController: NSViewController {
    var scriptsTableView: ScriptsTableView?
    var viewModel: ScriptViewModel? = ScriptViewModel.shared {
        didSet {
            scriptsTableView?.viewModel = viewModel
        }
    }
    
    override func loadView() {
        self.view = NSView()
        
        scriptsTableView = ScriptsTableView(frame: .zero)
        scriptsTableView?.setup()
        scriptsTableView?.viewModel = viewModel
        
        let scrollView = NSScrollView()
        scrollView.documentView = scriptsTableView
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        scriptsTableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
}
