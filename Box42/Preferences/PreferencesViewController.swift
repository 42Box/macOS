//
//  PreferencesViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 7/24/23.
//

import Cocoa
import Foundation

class PreferencesViewController: NSViewController {
    let menubarVC = MenubarViewController()
    private var stackView: NSStackView!
    private var rightView: NSView!
    private var outputView: NSTextView!
    
    override func loadView() {
        self.view = NSView()
        self.stackView = NSStackView()
        self.stackView.orientation = .vertical
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
        
        outputView = NSTextView()
        outputView.translatesAutoresizingMaskIntoConstraints = false
        rightView.addSubview(outputView)

        NSLayoutConstraint.activate([
            outputView.topAnchor.constraint(equalTo: rightView.topAnchor),
            outputView.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            outputView.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            outputView.bottomAnchor.constraint(equalTo: rightView.bottomAnchor)
        ])

        
        var stackBox: [NSView] = []
        
        
        let scripts = Scripts().info
        scripts.forEach { (script) in
            stackBox.append(NSButton(title: "\(script.name) Script: \(script.description)", target: self, action: #selector(scriptButtonPressed)))
            
        }
        
//        let scriptButton = NSButton(title: "Script", target: self, action: #selector(scriptButtonPressed))
        let appleScriptButton = NSButton(title: "Apple Script", target: self, action: #selector(scriptButtonPressed))
        let etcButton = NSButton(title: "Etc.", target: self, action: #selector(etcButtonPressed))
        
//        stackBox.append(scriptButton)
        stackBox.append(appleScriptButton)
        stackBox.append(etcButton)
        let buttonStackView = NSStackView(views: stackBox)
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
    
    @objc func changeIconButtonPressed(_ sender: NSButton) {
        // Change the content of the right view for icon changing
        let icon = sender.title.split(separator: " ").map{String($0)}
        print(icon[1])
        menubarVC.menubarStopRunning()
        menubarVC.buttonImageChange(icon[1])
        menubarVC.menubarStartRunning()
    }
    
    @objc func scriptButtonPressed(_ sender: NSButton) {
        let script = sender.title.split(separator: " ").map{String($0)}
        if script[1] == "Script:" {
            if let scriptPath = Bundle.main.path(forResource: script[0], ofType: "sh") {
                let task = Process()
                task.launchPath = "/bin/sh"
                task.arguments = [scriptPath]

                let outputPipe = Pipe()
                task.standardOutput = outputPipe
                task.standardError = outputPipe
                
                
                task.standardError = outputPipe
                
//                outputPipe.fileHandleForReading.readabilityHandler = { [weak self] fileHandle in
//                    if #available(OSX 10.15.4, *) {
//                        if let data = try? fileHandle.readToEnd(), let output = String(data: data, encoding: .utf8) {
//                            DispatchQueue.main.async {
//                                if let outputView = self?.outputView {
//                                    outputView.string += "\(output)"
//                                } else {
//                                    print("outputView is nil")
//                                }
//                            }
//                        }
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                }
                        
                        
                task.launch()
                task.waitUntilExit()

//                let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
//                let output = String(data: outputData, encoding: .utf8) ?? ""
//                print("Output: \(output)")
            } else {
                print("Script not found")
            }
        } else if sender.title == "Apple Script" {
            let appleScriptCode = "display dialog \"Hello, World!\""

            if let appleScript = NSAppleScript(source: appleScriptCode) {
                var errorDict: NSDictionary? = nil
                appleScript.executeAndReturnError(&errorDict)
                
                if let error = errorDict {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    @objc func etcButtonPressed() {
        // Change the content of the right view for etc.
    }
}

