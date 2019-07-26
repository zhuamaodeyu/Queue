//
//  MenuTableViewCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit
import TKFoundationModule

class MenuTableViewCell: NSTableCellView {

    private var iconImageView: NSImageView!
    private var titleLabel: NSTextField!
    private var unreadCountView: NSTextField!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.unreadCountView.layer?.cornerRadius = (self.unreadCountView.cell?.cellSize.height) ?? 0 / 2
        self.unreadCountView.layer?.masksToBounds = true
    }

    override var objectValue: Any? {
        didSet {
            if let model =  objectValue as? MenuModel {
                self.iconImageView.image = NSImage.init(named: model.icon)
                self.titleLabel.stringValue = model.name
                self.unreadCountView.stringValue = "\(model.unreadCount)"
                self.unreadCountView.updateLayer()
                if model.unreadCount == 0 {
                    self.unreadCountView.isHidden = true
                }else {
                    self.unreadCountView.isHidden = false
                }
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

        unreadCountView = NSTextField.init()
        unreadCountView.userInteractionEnabled = false
        let cell = VerticallyCenteredTextFieldCell.init()
        cell.mIsEditingOrSelecting = true
        cell.alignment = .center
        cell.backgroundColor = NSColor.yellow
        unreadCountView.cell = cell
        unreadCountView.stringValue = "0"
        unreadCountView.isBordered = false
        unreadCountView.isSelectable = false
        unreadCountView.isEditable = false
        unreadCountView.isBezeled = false
        unreadCountView.backgroundColor = NSColor.systemRed
        unreadCountView.drawsBackground = true
        unreadCountView.alignment = .center
        unreadCountView.focusRingType = .none
        unreadCountView.sizeToFit()
        self.addSubview(unreadCountView)


        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.size.equalTo(CGSize.init(width: 25, height: 25))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(iconImageView.snp.right).offset(10)
        }
        unreadCountView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(CGSize.init(width:self.unreadCountView.frame.size.width + 10,
                                          height:self.unreadCountView.frame.size.height + 10))
        }

        iconImageView.backgroundColor = NSColor.randomColor
    }
}
