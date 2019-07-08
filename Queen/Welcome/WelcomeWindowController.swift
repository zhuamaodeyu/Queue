//
//  WelcomeWindowController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class WelcomeWindowController: NSWindowController {

    override func windowWillLoad() {
        super.windowWillLoad()
    }

    override func loadWindow() {
        super.loadWindow()
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // 隐藏titleBar 透明
        window?.titlebarAppearsTransparent = true
        // 隐藏 title
        window?.titleVisibility = .hidden
        //
        window?.backgroundColor = .white
        // 隐藏
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = true

        window?.standardWindowButton(.zoomButton)?.isHidden = true
        // 背景可移动
        window?.isMovableByWindowBackground = true

        window?.isRestorable = false

        configWindowFrameSize()

        window?.center()
    }
}

extension WelcomeWindowController {
    private func configWindowFrameSize() {
        var frame = NSScreen.main?.visibleFrame
        frame?.size.width = 560
        frame?.size.height = 480
        self.window?.setFrame(frame ?? CGRect.zero, display: true)
    }
}

