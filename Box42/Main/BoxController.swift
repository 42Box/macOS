//
//  BoxViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Cocoa
import AppKit
import WebKit

class BoxController: NSViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
	let url = URLModel()
	var ad = NSApplication.shared.delegate as? AppDelegate
	var topAnchorDistance: CGFloat = 0
	
	@IBOutlet var divider: NSBox!
	@IBOutlet weak var boxView: NSView!
	@IBOutlet weak var buttonViewGroup: NSView!
	@IBOutlet weak var hostingViewGroup: NSView!
	@IBOutlet var pinSwitch: NSSwitch!
	
	private var webView: WKWebView!
	private var buttonBoxGroup: NSView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		buttonBoxGroupInit()
		boxViewSizeInit()
		webViewInit()
		configureButton()
		webViewLoad(url.URLdict["Box 42"]!)
	}
	
	func createButton(_ title :String) {
		let button = NSButton()
		button.title = title
		button.setButtonType(.momentaryLight)
		
		button.translatesAutoresizingMaskIntoConstraints = false
		button.action =  #selector(self.clickBtn(sender:))
		button.isBordered = true
		button.bezelStyle = .roundRect
		button.showsBorderOnlyWhileMouseInside = true
		
		buttonBoxGroup.addSubview(button)

		button.leadingAnchor.constraint(equalTo: buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
		button.topAnchor.constraint(equalTo: buttonBoxGroup.topAnchor, constant: topAnchorDistance).isActive = true
		topAnchorDistance += 30
		button.trailingAnchor.constraint(equalTo: buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
	}
	
	func createHomeButton() {
		let button = NSButton(title: "home", image: NSImage(imageLiteralResourceName: "42box_logo"), target: (Any).self, action: #selector(self.clickBtn(sender:)))
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isBordered = false
		button.imagePosition = .imageOnly
		
		buttonBoxGroup.addSubview(button)

		button.leadingAnchor.constraint(equalTo: buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
		button.topAnchor.constraint(equalTo: buttonBoxGroup.topAnchor, constant: topAnchorDistance).isActive = true
		topAnchorDistance += 80
		button.trailingAnchor.constraint(equalTo: buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
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
		
		buttonBoxGroup.addSubview(button)

		button.leadingAnchor.constraint(equalTo: buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
		button.bottomAnchor.constraint(equalTo: buttonBoxGroup.bottomAnchor, constant: -10).isActive = true
		button.trailingAnchor.constraint(equalTo: buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
	}
	
	func divide() {
		divider.translatesAutoresizingMaskIntoConstraints = false
		divider.bottomAnchor.constraint(equalTo: buttonBoxGroup.bottomAnchor, constant: -40).isActive = true
	}
	
	func createPinButton() {
		let button = NSButton()
		button.title = "Pin Box"
		button.setButtonType(.toggle)
		button.contentTintColor = .orange
		button.translatesAutoresizingMaskIntoConstraints = false
		button.action =  #selector(self.pin)
		button.isBordered = true
		button.bezelStyle = .roundRect
		button.showsBorderOnlyWhileMouseInside = true
		
		buttonBoxGroup.addSubview(button)

		button.leadingAnchor.constraint(equalTo: buttonBoxGroup.leadingAnchor, constant: 20).isActive = true
		button.bottomAnchor.constraint(equalTo: buttonBoxGroup.bottomAnchor, constant: -50).isActive = true
		button.trailingAnchor.constraint(equalTo: buttonBoxGroup.trailingAnchor, constant: -20).isActive = true
	}
	
	func configureButton() {
		createHomeButton()
		for i in 1..<url.URLstring.count {
			createButton(url.URLstring[i].0)
		}
		divide()
		createQuitButton()
		createPinButton()
	}
	
	@objc
	func clickBtn(sender: NSButton) {
		webViewLoad(url.URLdict[sender.title]!)
		print(url.URLdict[sender.title] ?? "not found url")
	}
	
	@objc
	func pin(_ sender: NSSwitch) {
		ad?.boxStatus.isPin.toggle()
		print(sender.state)
	}
	
	func boxViewSizeInit() {
		boxView.frame.size.width = BoxViewSize().size.width
		boxView.frame.size.height = BoxViewSize().size.height
		
		hostingViewGroup.frame.size.width = BoxViewSize().size.width - BoxViewSize().buttonGroupSize.width
		hostingViewGroup.frame.size.height = BoxViewSize().size.height
		
		buttonViewGroup.frame.size.width = BoxViewSize().buttonGroupSize.width
		buttonViewGroup.frame.size.height = BoxViewSize().buttonGroupSize.height
	}
	
	func buttonBoxGroupInit() {
		buttonBoxGroup = NSView(frame: NSRect(x: 0, y: 0, width: BoxViewSize().buttonGroupSize.width, height: BoxViewSize().buttonGroupSize.height))
		buttonBoxGroup.frame.size.width = BoxViewSize().buttonGroupSize.width
		buttonBoxGroup.frame.size.height = BoxViewSize().buttonGroupSize.height
		buttonViewGroup.addSubview(buttonBoxGroup)
		
		setAutoLayout(from: buttonBoxGroup, to: buttonViewGroup)
	}
	
	func webViewInit() {
		let preferences = WKPreferences()
		preferences.javaScriptEnabled = true
		preferences.javaScriptCanOpenWindowsAutomatically = true
		
		let contentController = WKUserContentController()
		contentController.add(self, name: "Boxing")
		
		let configuration = WKWebViewConfiguration()
		configuration.preferences = preferences
		configuration.userContentController = contentController
		
		webView = WKWebView(frame: hostingViewGroup.frame, configuration: configuration)
		
		webView.uiDelegate = self
		webView.navigationDelegate = self
		hostingViewGroup.addSubview(webView)
		setAutoLayout(from: webView, to: hostingViewGroup)
	}
	
	func webViewLoad(_ rqurl: URL) {
		let request = URLRequest(url: rqurl)
		DispatchQueue.main.async {
			self.webView.load(request)
		}
	}
	
	public func setAutoLayout(from: NSView, to: NSView) {
		from.translatesAutoresizingMaskIntoConstraints = false
		to.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.init(item: from, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint.init(item: from, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint.init(item: from, attribute: .top, relatedBy: .equal, toItem: to, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
		NSLayoutConstraint.init(item: from, attribute: .bottom, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
		view.layout()
	}
	
	func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
		print(message.name)
	}
}

extension BoxController {
	static func freshController() -> BoxController {
		let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let identifier = NSStoryboard.SceneIdentifier("BoxController")
		
		guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? BoxController else {
			fatalError("Story Board Not Found")
		}
		return viewcontroller
	}
}
