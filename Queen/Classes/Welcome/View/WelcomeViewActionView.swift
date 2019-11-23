//
//  WelcomeViewActionView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class WelcomeViewActionView: NSControl {

    private var iconImageView: NSImageView!
    private var titleLabel: NSTextField!
    private var descLabel:NSTextField!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
        initSubviewsConstaints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        sendAction(self.action, to: self.target)
    }
}





extension WelcomeViewActionView {
    func updateUI(image: NSImage, title: String, desc: String)  {
        self.iconImageView.image = image
        titleLabel.stringValue =  title
        descLabel.stringValue = desc
    }
}

extension WelcomeViewActionView {
    private func installSubviews() {
        iconImageView = NSImageView.init()
        addSubview(iconImageView)

        titleLabel = NSTextField.init()
        titleLabel.isEditable = false
        titleLabel.isSelectable = true
        titleLabel.isBordered = false
        titleLabel.maximumNumberOfLines = 1
        titleLabel.font = NSFont.boldSystemFont(ofSize: 15)
        titleLabel.isEnabled = false
        titleLabel.drawsBackground = false 
        addSubview(titleLabel)

        descLabel = NSTextField.init()
        descLabel.isEditable = false
        descLabel.isSelectable = true
        descLabel.isBordered = false
        descLabel.maximumNumberOfLines = 1
        descLabel.isEnabled = false
        descLabel.font = NSFont.systemFont(ofSize: 13)
        descLabel.drawsBackground = false
        addSubview(descLabel)
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
            make.bottom.equalTo(self.snp.centerY).offset(-2)
            make.right.equalTo(self).offset(-10)
        }
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(self.snp.centerY).offset(3)
            make.width.equalTo(titleLabel)
        }
    }
}

