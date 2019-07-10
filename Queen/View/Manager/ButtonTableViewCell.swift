//
//  ButtonTableViewCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/10.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class ButtonTableViewCell: NSTableCellView {

    private var button: NSButton!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
        self.backgroundColor = NSColor.yellow
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}


extension ButtonTableViewCell {
    private func installSubviews() {
        button = NSButton.init()
        button.sizeToFit()
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
}

extension ButtonTableViewCell {
    @objc private func buttonAction() {
        debugPrint("Action")
    }
}
