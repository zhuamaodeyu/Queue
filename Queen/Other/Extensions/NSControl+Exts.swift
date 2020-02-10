//
//  NSControl+Exts.swift
//  Queen
//
//  Created by 聂子 on 2020/2/9.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

extension NSControl {
    func addTarget(_ target: AnyObject?, action: Selector) {
        self.action = action
        self.target = target
    }
}
