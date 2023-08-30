//
//  FunctionButtonViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/20/23.
//

import Cocoa

class BoxFunctionViewController: NSViewController {
    
    var pinButtonView: PinButtonView?
    
    override func loadView() {
        let functionViewGroup = BoxFunctionViewGroup()
        
        pinButtonView = functionViewGroup.pinButton
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
        StateManager.shared.togglePin()
        
        let newImage: NSImage
        if StateManager.shared.pin {
            newImage = NSImage(imageLiteralResourceName: "pin-box-ver")
        } else {
            newImage = NSImage(imageLiteralResourceName: "pin-box")
        }
        
        pinButtonView?.changePinImage(to: newImage)  // 이미지 변경
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
