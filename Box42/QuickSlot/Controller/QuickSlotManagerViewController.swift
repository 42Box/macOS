//
//  QuickSlotManagerViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import AppKit

class QuickSlotManagerViewController: NSViewController {
    var quickSlotManagerTableView: QuickSlotTableView?
    var viewModel: QuickSlotViewModel? = QuickSlotViewModel.shared {
        didSet {
            quickSlotManagerTableView?.viewModel = viewModel
        }
    }
    
    override func loadView() {
        self.view = NSView()
        
        quickSlotManagerTableView = QuickSlotTableView(frame: .zero)
        quickSlotManagerTableView?.setup()
        quickSlotManagerTableView?.viewModel = viewModel
        
        let scrollView = NSScrollView()
        scrollView.documentView = quickSlotManagerTableView
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        quickSlotManagerTableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
}
