//
//  LoginWindowController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/19.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        // 隐藏titleBar透明
        window?.titlebarAppearsTransparent = true
        // 隐藏title
        window?.titleVisibility = .hidden
        // 背景白色
//        window?.backgroundColor = .white
        // 隐藏miniaturize按钮
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        // 隐藏zoom按钮
        window?.standardWindowButton(.zoomButton)?.isHidden = true
        // 背景可以移动
        window?.isMovableByWindowBackground = true

        window?.isRestorable = true
        window?.center()
    }

}
