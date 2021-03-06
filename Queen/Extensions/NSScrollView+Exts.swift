//
//  NSScrollView+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/9.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import Cocoa


extension NSScrollView {

    private func transparentizeHeaderClipView() {

        let clips = self.subviews.compactMap { $0 as? NSClipView }
        guard let headclip = clips.filter({ $0 !== self.contentView }).first,
            let content = headclip.documentView
            else { return }

        let visualEffectView = NSVisualEffectView(frame: NSRect.zero)
        visualEffectView.material = NSVisualEffectView.Material.light
        visualEffectView.blendingMode = NSVisualEffectView.BlendingMode.behindWindow
        visualEffectView.state = NSVisualEffectView.State.active

        headclip.documentView = visualEffectView
        visualEffectView.addSubview(content)
    }
}

extension NSScrollView {

    /// Scroll to the ducument view top.
    public func scrollToTop() {
        if let documentView = self.documentView {
            if documentView.isFlipped {
                documentView.scroll(.zero)
            } else {
                let maxHeight = max(bounds.height, documentView.bounds.height)
                documentView.scroll(NSPoint(x: 0, y: maxHeight))
            }
        }
    }
}


