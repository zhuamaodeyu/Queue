//
//  WelcomeTableViewCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit

class WelcomeTableViewCell: NSTableCellView {
    private var iconImageView: NSImageView!
    private var titleLabel: NSTextField!
    private var descLabel:NSTextField!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
        initSubviewsConstaints()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
}

extension WelcomeTableViewCell {
    func updateUI(image: NSImage, title: String, desc: String)  {
        self.iconImageView.image = image
        titleLabel.stringValue =  title
        descLabel.stringValue = desc
    }
}

extension WelcomeTableViewCell {
    private func installSubviews() {
        iconImageView = NSImageView.init()
        addSubview(iconImageView)

        titleLabel = NSTextField.init()
        titleLabel.isEditable = false
        titleLabel.isSelectable = true
        titleLabel.isBordered = false
        titleLabel.maximumNumberOfLines = 1
        titleLabel.font = NSFont.init(name: "", size: 20.0)
        titleLabel.textColor = NSColor.withHex(hexString: "")
        addSubview(titleLabel)

        descLabel = NSTextField.init()
        descLabel.isEditable = false
        descLabel.isSelectable = true
        descLabel.isBordered = false
        descLabel.maximumNumberOfLines = 1
        descLabel.textColor = NSColor.withHex(hexString: "")
        descLabel.font = NSFont.init(name: "", size: 16.0)
        addSubview(descLabel)

        iconImageView.backgroundColor = NSColor.randomColor
        titleLabel.backgroundColor = NSColor.randomColor
        descLabel.backgroundColor = NSColor.randomColor
    }


    private func initSubviewsConstaints() {
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(iconImageView.snp.height)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.bottom.equalTo(self.snp.centerY).offset(-5)
            make.right.equalTo(self).offset(-10)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(self.snp.centerY).offset(5)
            make.width.equalTo(titleLabel)
        }
    }
}
