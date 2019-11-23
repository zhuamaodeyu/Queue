//
//  BuriedPoint3DShowViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/9/28.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class BuriedPoint3DShowViewController: NSViewController {

 
}

extension BuriedPoint3DShowViewController {
    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = NSColor.randomColor
    }
    
}
