//
//  DocumentListTableViewCell.swift
//  Queen
//
//  Created by 聂子 on 2020/2/9.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

class DocumentListTableViewCell: NSTableCellView {
    private let titleLabel: NSTextField = NSTextField.init()
    private let descLabel = NSTextField.init()
    private let favoriteButton = NSButton.init()
    override init(frame frameRect: NSRect) {
          super.init(frame: frameRect)
          installSubviews()
          initSubviewsConstaints()
      }

      required init?(coder decoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}

extension DocumentListTableViewCell {
    private func installSubviews() {
        titleLabel.isEditable = false
        titleLabel.isSelectable = true
        titleLabel.isBordered = false
        titleLabel.maximumNumberOfLines = 1
        titleLabel.font = NSFont.init(name: "", size: 20.0)
        titleLabel.textColor = NSColor.withHex(hexString: "")
        addSubview(titleLabel)
        
        
        descLabel.isEditable = false
        descLabel.isSelectable = true
        descLabel.isBordered = false
        descLabel.maximumNumberOfLines = 1
        descLabel.font = NSFont.init(name: "", size: 14.0)
        descLabel.textColor = NSColor.withHex(hexString: "")
        addSubview(descLabel)
        
        addSubview(favoriteButton)
        
    }
    
    private func initSubviewsConstaints() {
        
        favoriteButton.snp.makeConstraints { (make) in
            make.size.equalTo(NSSize.init(width: 45, height: 45))
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self.snp.centerY).offset(5)
            make.right.equalTo(favoriteButton.snp.left).offset(-10)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(self).offset(-10)
        }
    }
}
extension DocumentListTableViewCell {
    
}
