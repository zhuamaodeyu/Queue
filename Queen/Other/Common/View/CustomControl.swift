//
//  CustomControl.swift
//  Queen
//
//  Created by 聂子 on 2020/2/9.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

class CustomControl: NSControl {
    
   override var acceptsFirstResponder: Bool {
       return true
   }

   override func becomeFirstResponder() -> Bool {
       return true
   }


   override func mouseDown(with event: NSEvent) {
       window?.makeFirstResponder(self)
   }

   override func mouseUp(with event: NSEvent) {
       if let action = action {
           NSApp.sendAction(action, to: target, from: self)
       }
   }


   override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
//       NSColor.white.set()
//       NSBezierPath(roundedRect: bounds.insetBy(dx: 1, dy: 1), xRadius: 3, yRadius: 3).fill()
//
//       if window?.firstResponder == self {
//           NSColor.keyboardFocusIndicatorColor.set()
//       } else {
//           NSColor.black.set()
//       }
//       NSBezierPath(roundedRect: bounds.insetBy(dx: 1, dy: 1), xRadius: 3, yRadius: 3).stroke()
   }


   override var focusRingMaskBounds: NSRect {
       return bounds.insetBy(dx: 1, dy: 1)
   }


   override func drawFocusRingMask() {
        super.drawFocusRingMask()
//       NSBezierPath(roundedRect: bounds.insetBy(dx: 1, dy: 1), xRadius: 3, yRadius: 3).fill()
   }
    
}
