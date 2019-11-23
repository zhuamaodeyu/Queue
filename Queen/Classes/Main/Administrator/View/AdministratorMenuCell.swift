//
//  AdministratorMenuCell.swift
//  Queen
//
//  Created by 聂子 on 2019/7/28.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


class AdministratorMenuCell: NSCollectionViewItem {
    private var iconView: NSImageView!
    private var nameLabel: NSTextField!

    private var model: AdministratorMenuModel?


    override func loadView() {
        self.view = NSView.init()
    }
}

extension AdministratorMenuCell {
    private func installSubviews() {
        iconView = NSImageView.init()
        self.view.addSubview(iconView)

        nameLabel = NSTextField.init()
        nameLabel.placeholderString = ""
        nameLabel.font = NSFont.systemFont(ofSize: 13)
        nameLabel.isBordered = false
        nameLabel.drawsBackground = false
        nameLabel.alignment = .center
        nameLabel.focusRingType = .none
        self.view.addSubview(nameLabel)

        iconView.snp.makeConstraints { (make) in

        }
        nameLabel.snp.makeConstraints { (make) in

        }

    }
}

extension AdministratorMenuCell {
    func config(model: AdministratorMenuModel)  {
        self.model = model
        self.view.backgroundColor = model.select ? NSColor.red : NSColor.blue
    }
}
