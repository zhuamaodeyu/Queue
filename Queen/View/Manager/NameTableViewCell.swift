//
//  NameTableViewCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/10.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class NameTableViewCell: NSTableCellView {

    private var button: NSButton!
    private var document: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.backgroundColor = NSColor.red
        // Drawing code here.
    }
    
}
