//
//  RightContentViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class RightContentViewController: NSViewController {

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = NSColor.randomColor 
    }
    
}
