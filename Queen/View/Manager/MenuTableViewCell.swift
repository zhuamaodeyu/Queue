//
//  MenuTableViewCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit

class MenuTableViewCell: NSTableCellView {

    private var iconImageView: NSImageView!
    private var titleLabel: NSTextField!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }

    override var objectValue: Any? {
        didSet {
            if let model =  objectValue as? MenuModel {
                    self.iconImageView.image = NSImage.init(named: model.icon)
                    self.titleLabel.stringValue = model.name
            }
        }
    }
    
}

extension MenuTableViewCell {
    private func installSubviews() {
        iconImageView = NSImageView.init()
        self.addSubview(iconImageView)
        titleLabel = NSTextField.init()
        titleLabel.font = NSFont.systemFont(ofSize: 15.0)
        titleLabel.isEditable = false
        titleLabel.isBezeled = false
        titleLabel.stringValue = "Queue"
        titleLabel.sizeToFit()
        titleLabel.drawsBackground = false
        titleLabel.isSelectable = false
        titleLabel.alignment = .center
        titleLabel.isBordered = false
        self.addSubview(titleLabel)


        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.size.equalTo(CGSize.init(width: 25, height: 25))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(iconImageView.snp.right).offset(10)
        }

        iconImageView.backgroundColor = NSColor.randomColor
    }
}
