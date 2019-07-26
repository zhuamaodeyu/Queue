//
//  VerticallyCentered+TextFieldCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/24.
//  Copyright © 2019 聂子. All rights reserved.
//

import AppKit


class VerticallyCenteredTextFieldCell:NSTextFieldCell {
    var mIsEditingOrSelecting:Bool = false

    
    override func titleRect(forBounds rect: NSRect) -> NSRect {
        var titleFrame = super.titleRect(forBounds: rect)
        let titleSize = self.attributedStringValue.size()
        titleFrame.origin.y = rect.origin.y + (rect.size.height - titleSize.height) / 2.0
        return titleFrame
    }
    override func drawingRect(forBounds theRect: NSRect) -> NSRect {
        //Get the parent's idea of where we should draw
        var newRect:NSRect = super.drawingRect(forBounds: theRect)

        // When the text field is being edited or selected, we have to turn off the magic because it screws up
        // the configuration of the field editor.  We sneak around this by intercepting selectWithFrame and editWithFrame and sneaking a
        // reduced, centered rect in at the last minute.

        if !mIsEditingOrSelecting {
            // Get our ideal size for current text
            let textSize:NSSize = self.cellSize(forBounds: theRect)

            //Center in the proposed rect
            let heightDelta:CGFloat = newRect.size.height - textSize.height
            if heightDelta > 0 {
                newRect.size.height -= heightDelta
                newRect.origin.y += heightDelta/2
            }
        }

        return newRect
    }
    override func select(withFrame rect: NSRect,
                         in controlView: NSView,
                         editor textObj: NSText,
                         delegate: Any?,
                         start selStart: Int,
                         length selLength: Int)//(var aRect: NSRect, inView controlView: NSView, editor textObj: NSText, delegate anObject: AnyObject?, start selStart: Int, length selLength: Int)
    {
        let arect = self.drawingRect(forBounds: rect)
        mIsEditingOrSelecting = true;
        super.select(withFrame: arect, in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
        mIsEditingOrSelecting = false;
    }

    override func edit(withFrame rect: NSRect,
                       in controlView: NSView,
                       editor textObj: NSText,
                       delegate: Any?,
                       event: NSEvent?)
    {
        let aRect = self.drawingRect(forBounds: rect)
        mIsEditingOrSelecting = true;
        super.edit(withFrame: aRect, in: controlView, editor: textObj, delegate: delegate, event: event)
        mIsEditingOrSelecting = false
    }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {

       super.drawInterior(withFrame: cellFrame, in: controlView)
        debugPrint("")
    }
    override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.draw(withFrame: cellFrame, in: controlView)
//        let cellSize = self.cellSize(forBounds: cellFrame)
//        super.draw(withFrame: CGRect.init(x: cellFrame.origin.x, y: (cellFrame.size.height - cellSize.height) / 2, width: cellSize.height, height: cellSize.height), in: controlView)
        debugPrint("")
    }
    override func draw(withExpansionFrame cellFrame: NSRect, in view: NSView) {
        super.draw(withExpansionFrame: cellFrame, in: view)
        debugPrint("")
    }
}
