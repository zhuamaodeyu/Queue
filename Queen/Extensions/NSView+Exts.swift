//
//  NSView+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

extension NSView {
    public var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }


    public func removeAllSubviews() {
        self.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
    }

    public func animationUpdate() {
        self.updateConstraintsForSubtreeIfNeeded()
        self.updateConstraints()
        self.layoutSubtreeIfNeeded()
    }
}

extension NSView {

    /// mouse in view
    ///
    /// - Returns: true / false 
    public func mouseInView() -> Bool {
        if self.window == nil {
            return false
        }
        if self.isHidden {
            return false
        }
        var point = NSEvent.mouseLocation
        point = self.window?.convertFromScreen(NSRect.init(origin: point, size: CGSize.init(width: 0, height: 0))).origin ?? CGPoint.init(x: 0, y: 0)
        point = self.convert(point, from: nil)
        return NSPointInRect(point, self.visibleRect)
    }

}
