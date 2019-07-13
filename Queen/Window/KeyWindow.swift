//
//  KeyWindow.swift
//  Queen
//
//  Created by 聂子 on 2019/7/13.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class KeyWindow: NSWindow {

    override var canBecomeKey: Bool {
        get {
            return true 
        }
    }
}


