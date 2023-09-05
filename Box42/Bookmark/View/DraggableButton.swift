//
//  DraggableButton.swift
//  Box42
//
//  Created by Chanhee Kim on 9/5/23.
//

import AppKit

class DraggableButton: NSButton, NSDraggingSource {
    weak var delegate: BoxBaseContainerViewController?
    var mouseDownEvent: NSEvent?
    
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .move
    }
    var initialMouseDownPoint: CGPoint?
    
    override func mouseDown(with event: NSEvent) {
        print("mouseDown")
        self.initialMouseDownPoint = event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let initialPoint = self.initialMouseDownPoint else { return }
        
        let distance = hypot(
            initialPoint.x - event.locationInWindow.x,
            initialPoint.y - event.locationInWindow.y)
        
        if distance > 3 { // 드래그로 판단하는 최소 거리. 필요에 따라 조절 가능합니다.
            let pasteboardItem = NSPasteboardItem()
            pasteboardItem.setString("\(self.tag)", forType: .string)
            
            let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
            
            // Create a snapshot of the button
            let snapshot = self.snapshot()
            
            // Set the dragging frame and contents
            draggingItem.setDraggingFrame(self.bounds, contents: snapshot)
            
            beginDraggingSession(with: [draggingItem], event: event, source: self)
            
            self.initialMouseDownPoint = nil
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        guard let initialPoint = self.initialMouseDownPoint else { return }
        
        let distance = hypot(
            initialPoint.x - event.locationInWindow.x,
            initialPoint.y - event.locationInWindow.y)
        
        if distance < 3 { // 클릭으로 판단하는 최대 거리. 필요에 따라 조절 가능합니다.
            self.target?.perform(self.action, with: self)
        }
        
        self.initialMouseDownPoint = nil
    }
    
    func snapshot() -> NSImage? {
        guard let bitmapRep = bitmapImageRepForCachingDisplay(in: bounds) else { return nil }
        cacheDisplay(in: bounds, to: bitmapRep)
        let image = NSImage(size: bounds.size)
        image.addRepresentation(bitmapRep)
        return image
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        let trackingArea = NSTrackingArea(
            rect: bounds,
            options: [.mouseEnteredAndExited, .activeAlways],
            owner: self,
            userInfo: nil
        )
        
        addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        if self != delegate?.selectedButton {
            wantsLayer = true
            layer?.frame.size = CGSize(width: 268.0, height: 44.0)
            layer?.cornerRadius = 12
            layer?.backgroundColor = NSColor(red: 0.848, green: 0.848, blue: 0.848, alpha: 1).cgColor
        }
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        
        if self != delegate?.selectedButton {
            wantsLayer = true
            layer?.frame.size = CGSize(width: 268.0, height: 44.0)
            layer?.cornerRadius = 12
            layer?.backgroundColor = NSColor.clear.cgColor
        }
    }
}
