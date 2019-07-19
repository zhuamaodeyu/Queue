//
//  IconImageView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/19.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class IconImageView: NSImageView {

    private var trackingArea: NSTrackingArea?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.cornerRadius = bounds.width / 2
        layer?.masksToBounds = true
        setLayerBoard(.lightGray, width: 1)
    }

    override func mouseEntered(with event: NSEvent) {
        setLayerBoard(NSColor.init(red:0.52, green:0.84, blue:0.96, alpha:1.00), width: 3)
    }

    override func mouseExited(with event: NSEvent) {
        setLayerBoard(.lightGray, width: 1)
    }
    private func setLayerBoard(_ color:NSColor, width: CGFloat) {
        layer?.borderColor = color.cgColor
        layer?.borderWidth = width
    }


    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let t = trackingArea {
            removeTrackingArea(t)
        }
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [
            .inVisibleRect,
            .activeAlways,
            .mouseEnteredAndExited
            ], owner: self, userInfo: nil)
        if let t = trackingArea {
            addTrackingArea(t)
        }
    }

}
