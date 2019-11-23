//
//  MainWindowController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {


}

extension MainWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // 隐藏titleBar 透明
        window?.titlebarAppearsTransparent = true
        // 隐藏 title
        window?.titleVisibility = .hidden
        // 隐藏
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = false
        
        window?.standardWindowButton(.zoomButton)?.isHidden = false
        // 背景可移动
        window?.isMovableByWindowBackground = true
        
        window?.isRestorable = false
        
        configWindowFrameSize()
        
        window?.center()
        
        window?.minSize = CGSize.init(width: 1160, height: 760)
    }
}


extension MainWindowController {
    private func configWindowFrameSize() {
        var frame = NSScreen.main?.visibleFrame
        frame?.size.width = 1160
        frame?.size.height = 760
        self.window?.setFrame(frame ?? CGRect.zero, display: true)
    }
}

