//
//  PodContactViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/16.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class PodContactViewController: NSViewController {


}

extension PodContactViewController {
    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.backgroundColor = NSColor.randomColor
    }

}
