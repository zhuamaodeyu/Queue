//
//  TerminalPopUpButton.swift
//  Queen
//
//  Created by 聂子 on 2019/7/30.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class TerminalPopUpButton: NSPopUpButton {
    
    private var trackingArea: NSTrackingArea?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
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

