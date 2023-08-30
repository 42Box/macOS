//
//  Associated+NSButton.swift
//  Box42
//
//  Created by Chanhee Kim on 8/30/23.
//

import AppKit

private var AssociatedObjectKey: UInt8 = 0

extension NSButton {
    var associatedString: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKey) as? String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
