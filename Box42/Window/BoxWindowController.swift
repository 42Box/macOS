//
//  BoxWindowController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa

class BoxWindowController: NSWindowController {
    var windowInstance: NSWindow!
    var gradientView: NSView!
    
    override init(window: NSWindow?) {
        let contentRect = BoxSizeManager.shared.boxViewSizeNSRect
        let styleMask: NSWindow.StyleMask = [.titled, .closable, .resizable, .miniaturizable]
        windowInstance = NSWindow(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: false)
        windowInstance.title = "Box"
        windowInstance.styleMask.insert(.resizable)
        windowInstance.isReleasedWhenClosed = false
        windowInstance.isOpaque = false
        
        super.init(window: windowInstance)
        gradientView = GradientView(frame: contentRect)

        let boxViewController = BoxViewController(nibName: nil, bundle: nil)
        windowInstance.contentViewController = boxViewController
        windowInstance.contentView?.addSubview(gradientView, positioned: .below, relativeTo: nil)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientViewAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func gradientViewAutoLayout() {
        if let contentView = windowInstance.contentView {
            NSLayoutConstraint.activate([
                gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                gradientView.topAnchor.constraint(equalTo: contentView.topAnchor),
                gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
