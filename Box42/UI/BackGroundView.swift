//
//  GradientView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

// MARK: - BackGround Gradient
//layer caching 기법.
//레이어 캐싱: 복잡한 그래픽 연산이 필요한 뷰의 경우 wantsLayer를 true로 설정하고 shouldRasterize 속성을 true로 설정하여 렌더링 결과를 캐시할 수 있습니다. 하지만 이를 과도하게 사용하면 메모리 사용량이 증가할 수 있으므로 주의가 필요합니다.

class BackGroundView: NSView {
    private var initialLocation: NSPoint? // Mouse Drag Event
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupLayerCaching()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLayerCaching()
    }
    
    private func setupLayerCaching() {
        self.wantsLayer = true
        self.layer?.shouldRasterize = true
        self.layer?.rasterizationScale = self.window?.backingScaleFactor ?? 1.0
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let startingColor = NSColor(red: 1.0, green: 0.804, blue: 0.0, alpha: 0.9)
        let endingColor = NSColor(red: 1.0, green: 0.447, blue: 0.0, alpha: 0.7)
        let gradient = NSGradient(starting: startingColor, ending: endingColor)
        gradient?.draw(in: self.bounds, angle: 90)
    }
}

// MARK: - Mouse Drag Event
extension BackGroundView {
    override func mouseDown(with event: NSEvent) {
        // 창 내에서의 현재 마우스 위치를 저장합니다.
//        self.initialLocation = self.window?.convertPoint(fromScreen: event.locationInWindow)
    }

    override func mouseDragged(with event: NSEvent) {
//        guard let initialLocation = initialLocation, let window = self.window else {
//            return
//        }
//
//        let currentLocation = window.convertPoint(fromScreen: event.locationInWindow)
//        let newOrigin = CGPoint(x: window.frame.origin.x + (currentLocation.x - initialLocation.x),
//                                y: window.frame.origin.y + (currentLocation.y - initialLocation.y))
//
//        // 창의 위치를 업데이트합니다.
//        window.setFrameOrigin(newOrigin)
    }
}

