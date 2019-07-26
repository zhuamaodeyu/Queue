//
//  AdministratorViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class AdministratorViewController: NSViewController {

    /**
     1. 创建用户
     2. 创建项目组
     3. 创建spec 仓库
     */
    private var containterView: NSView!
    private var tableView: NSTableView!
    private var scrollView: NSScrollView!

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = NSColor.randomColor
    }
}

extension AdministratorViewController {

}
