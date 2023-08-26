//
//  RotateImage+NSImage.swift
//  Box42
//
//  Created by Chanhee Kim on 8/25/23.
//

import Cocoa

extension NSImage {
    func rotated(by degrees: CGFloat) -> NSImage? {
        guard let imgRep = self.bestRepresentation(for: NSRect(x: 0, y: 0, width: self.size.width, height: self.size.height), context: nil, hints: nil) else {
            return nil
        }
        
        let image = NSImage(size: self.size)
        
        image.lockFocus()
        let ctx = NSGraphicsContext.current?.cgContext
        ctx?.translateBy(x: size.width / 2, y: size.height / 2)
        ctx?.rotate(by: (degrees * CGFloat.pi) / 180)
        ctx?.translateBy(x: -size.width / 2, y: -size.height / 2)
        imgRep.draw(in: NSRect(x: 0, y: 0, width: size.width, height: size.height))
        image.unlockFocus()
        
        return image
    }
}
