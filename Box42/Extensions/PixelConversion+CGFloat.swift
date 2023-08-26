//
//  PixelConversion+CGFloat.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import Cocoa

extension CGFloat {
    func pointsToPixels() -> CGFloat {
        return self * 1.073
    }
    
    func pixelsToPoints() -> CGFloat {
        return self / 1.073
    }
    
    static func onePixelInPoints() -> CGFloat {
        return CGFloat(1).pixelsToPoints()
    }
}
