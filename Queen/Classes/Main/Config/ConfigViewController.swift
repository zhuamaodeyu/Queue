//
//  ConfigViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/10.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class ConfigViewController: NSViewController {

   
}

extension ConfigViewController {
    override func loadView() {
           self.view = NSView.init()
       }
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do view setup here.
           self.view.backgroundColor = NSColor.yellow
       }
       
}


extension ConfigViewController: MainSubViewControllerProtocol {
    var type: MenuType {
        return .none
    }
}
