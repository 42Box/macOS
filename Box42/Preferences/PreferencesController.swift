//
//  PreferencesView.swift
//  Box42
//
//  Created by Chanhee Kim on 7/24/23.
//

import Cocoa

class PreferencesViewController: NSViewController {
    
    private var stackView: NSStackView!
    private var rightView: NSView!
    
    override func loadView() {
        self.view = NSView()
        self.stackView = NSStackView()
        self.stackView.orientation = .horizontal
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 20
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let leftView = NSView()
        self.rightView = NSView()
        self.stackView.addArrangedSubview(leftView)
        self.stackView.addArrangedSubview(rightView)
        
        let iconButton = NSButton(title: "Change Icon", target: self, action: #selector(changeIconButtonPressed))
        let cronButton = NSButton(title: "Cron Script", target: self, action: #selector(cronButtonPressed))
        let etcButton = NSButton(title: "Etc.", target: self, action: #selector(etcButtonPressed))
        let buttonStackView = NSStackView(views: [iconButton, cronButton, etcButton])
        buttonStackView.orientation = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        leftView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: leftView.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor)
        ])
    }
    
    @objc func changeIconButtonPressed() {
        // Change the content of the right view for icon changing
    }
    
    @objc func cronButtonPressed() {
        // Change the content of the right view for cron script selection
    }
    
    @objc func etcButtonPressed() {
        // Change the content of the right view for etc.
    }
}

