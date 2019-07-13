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
    private var block:((_ button: NSButton) -> Void)?
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
}

extension ButtonTableViewCell {
    func config(image:NSImage?, title: String?,type: NSUserInterfaceItemIdentifier,complation:((_ button: NSButton) -> Void)?) {
        self.block = complation
        if let im = image {
            button.image = im
        }
        if let t = title {
            button.title = t
        }

        button.alignment = .center
        button.isBordered = false

        switch type {
        case TableViewIdentifier.version:
            button.setButtonType(.momentaryLight)
            button.bezelStyle = .texturedRounded
            button.isBordered = true
            break
        case TableViewIdentifier.hasBinrary:
            button.setButtonType(.switch)
            button.bezelStyle = .recessed
            button.isEnabled = false 

        case TableViewIdentifier.from:
            button.bezelStyle = .circular
            button.setButtonType(.accelerator)

        case TableViewIdentifier.manager:
            button.bezelStyle = .circular
            button.setButtonType(.accelerator)

        case TableViewIdentifier.test:
            button.setButtonType(.switch)
            button.bezelStyle = .recessed

        case TableViewIdentifier.collection:
            button.setButtonType(.accelerator)
            button.bezelStyle = .circular

        case TableViewIdentifier.building:
            button.setButtonType(.momentaryPushIn)
            button.bezelStyle = .texturedRounded
            button.isBordered = true
        default:
            break
        }
        self.animationUpdate()
    }
}

//button.imagePosition = .imageOnly
//button.setButtonType(.pushOnPushOff)
extension ButtonTableViewCell {
    private func installSubviews() {
        button = NSButton.init()
        button.target = self
        button.action = #selector(buttonAction(sender:))
        button.isBordered = false
        button.bezelStyle = .regularSquare
        button.focusRingType = .none

        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
    }
}

extension ButtonTableViewCell {
    @objc private func buttonAction(sender: NSButton) {
        self.block?(sender)
    }
}
