//
//  BoxButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxButtonView: BoxView {
    var topAnchorDistance: CGFloat = 0
    
    func createButton(_ title: String, clickAction: @escaping (NSButton) -> Void) {
        let button = NSButton()
        
        button.title = title
        button.setButtonType(.momentaryLight)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let handler = BoxButtonHandler()
        handler.clickAction = clickAction
        
        button.target = handler
        button.action =  #selector(handler.buttonClicked(_:))
        
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        super.buttonBoxGroup.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: super.buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: super.buttonBoxGroup.topAnchor, constant: topAnchorDistance).isActive = true
        topAnchorDistance += 30
        button.trailingAnchor.constraint(equalTo: super.buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
    }
    
    func createHomeButton(clickAction: @escaping (NSButton) -> Void) {
        let handler = BoxButtonHandler()
        handler.clickAction = clickAction
        
        let button = NSButton(title: "home", image: NSImage(imageLiteralResourceName: "42box_logo"), target: handler, action: #selector(handler.buttonClicked(_:)))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isBordered = false
        button.imagePosition = .imageOnly
        
        super.buttonBoxGroup.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: super.buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: super.buttonBoxGroup.topAnchor, constant: topAnchorDistance).isActive = true
        topAnchorDistance += 80
        button.trailingAnchor.constraint(equalTo: super.buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
    }
    
    func createQuitButton() {
        let button = NSButton()
        button.title = "Quit Box"
        button.setButtonType(.momentaryLight)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.action =  #selector(NSApplication.terminate(_:))
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        super.buttonBoxGroup.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: super.buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: super.buttonBoxGroup.bottomAnchor, constant: -10).isActive = true
        button.trailingAnchor.constraint(equalTo: super.buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
    }
    
    func createPinButton(clickAction: @escaping (NSButton) -> Void) {
        let button = NSButton()
        button.title = "Pin Box"
        button.setButtonType(.toggle)
        button.contentTintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let handler = BoxButtonHandler()
        handler.clickAction = clickAction
        
        button.target = handler
        button.action =  #selector(handler.buttonClicked(_:))

        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        super.buttonBoxGroup.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: super.buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: super.buttonBoxGroup.bottomAnchor, constant: -50).isActive = true
        button.trailingAnchor.constraint(equalTo: super.buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
    }
    
    func preferencesButton(clickAction: @escaping (NSButton) -> Void) {
        let button = NSButton()
        button.title = "Preferences"
        button.setButtonType(.momentaryLight)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let handler = BoxButtonHandler()
        handler.clickAction = clickAction
        
        button.target = handler
        button.action =  #selector(handler.buttonClicked(_:))
        
        button.isBordered = true
        button.bezelStyle = .roundRect
        button.showsBorderOnlyWhileMouseInside = true
        
        super.buttonBoxGroup.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: super.buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: super.buttonBoxGroup.bottomAnchor, constant: -90).isActive = true
        button.trailingAnchor.constraint(equalTo: super.buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
    }
    
}
