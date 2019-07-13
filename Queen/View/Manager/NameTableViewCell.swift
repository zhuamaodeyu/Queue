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
    private var document: NSButton!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func updateConstraints() {
        button.snp.updateConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
        document.snp.updateConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(button.snp.right).offset(10)
        }
        super.updateConstraints()
    }
}

extension NameTableViewCell {
    func config(name: String, document: Bool) {
        self.button.stringValue = name
        self.document.isHidden = document ? false : true
        self.animationUpdate()
    }
}

extension NameTableViewCell {
    private func installSubviews() {
        button = NSButton.init()
        button.target = self
        button.bezelStyle = .circular
        button.action = #selector(buttonAction)
        button.isBordered = false

        button.sizeToFit()
        self.addSubview(button)

        document = NSButton.init(title: "doc", target: nil, action: nil)
        document.acceptsTouchEvents = false
        button.sizeToFit()
        self.addSubview(document)
    }
}

extension NameTableViewCell {
    @objc private func buttonAction() {
        
    }
}
