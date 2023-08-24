//
//  FunctionButtonViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import Cocoa

class BoxFunctionViewController: NSViewController {
    override func loadView() {
        let functionViewGroup = BoxFunctionViewGroup()
        
        functionViewGroup.preferenceAction = preference
        functionViewGroup.pinAction = pin
        functionViewGroup.quitAction = quit
        functionViewGroup.boxAction = box
        
        self.view = functionViewGroup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func preference() {
        print("preference")
    }
    
    func pin() {
        print("pin")
    }
    
    func quit() {
        print("quit")
        NSApplication.shared.terminate(self)
    }
    
    weak var delegate: BoxFunctionViewControllerDelegate?

    func box() {
        print("box")
        delegate?.didTapBoxButton()
    }
}

protocol BoxFunctionViewControllerDelegate: AnyObject {
    func didTapBoxButton()
}
