//
//  NSLabel.swift
//  Queen
//
//  Created by 聂子 on 2019/9/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import AppKit

class NSLabel: NSTextField  {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.placeholderString = ""
        self.font = NSFont.systemFont(ofSize: 28)
        self.isBordered = false
        self.drawsBackground = false
        self.alignment = .left
        self.focusRingType = .none
        self.isSelectable = false
        self.isEditable = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
