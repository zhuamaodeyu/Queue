//
//  BuildingManagerCell.swift
//  Queen
//
//  Created by 聂子 on 2019/8/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

enum BuildingManagerCellStyle {
    case building
    case success
    case fail
    case none
}

class BuildingManagerCell: NSTableCellView {

    private var status: BuildingManagerCellStyle = .none
    private var iconImageView: NSImageView!
    private var titleLabel: NSTextField!

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

extension BuildingManagerCell {
    func updateUI(status: BuildingManagerCellStyle, title: String? = nil)  {
        if let title = title {
            self.titleLabel.stringValue = title
        }
        switch status {
        case .building:
            break
        case .fail:
            break
        case .success:
            break
        default:
            break
        }
    }
}

extension BuildingManagerCell {
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

        iconImageView.backgroundColor = NSColor.randomColor
        titleLabel.backgroundColor = NSColor.randomColor
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
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.right.equalTo(self).offset(-10)
        }
    }
}
