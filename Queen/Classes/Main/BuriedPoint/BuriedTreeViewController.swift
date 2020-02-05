//
//  BuriedTreeViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/9/28.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class BuriedTreeViewController: NSViewController {

  
}

extension BuriedTreeViewController {
    override func loadView() {
          self.view = NSView.init()
          installSubviews()
      }
      override func viewDidLoad() {
          super.viewDidLoad()
          self.view.backgroundColor = NSColor.randomColor
      }
      
}

extension BuriedTreeViewController {
    private func installSubviews() {

    }
}
