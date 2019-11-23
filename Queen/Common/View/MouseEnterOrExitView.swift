//
//  MouseEnterOrExitView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/7.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class MouseEnterOrExitView: NSView {

    private var trackingArea: NSTrackingArea?
    public var mouseEnteredCallBlock:((_ event:NSEvent)-> Void)?
    public var mouseExitedCallBlock:((_ event:NSEvent)-> Void)?

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        mouseEnteredCallBlock?(event)
    }
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        mouseExitedCallBlock?(event)
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
