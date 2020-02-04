//
//  BuriedPointShowViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/9/28.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class BuriedPointShowViewController: NSViewController {

}


extension BuriedPointShowViewController {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = NSColor.red
    }
}

extension BuriedPointShowViewController {
    private func installSubviews() {
     
    }
}


