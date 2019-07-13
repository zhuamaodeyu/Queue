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
        button.image =  image
        if let t = title {
            button.stringValue = t
        }
        switch type {
        case TableViewIdentifier.version:
            button.setButtonType(.momentaryLight)
            button.bezelStyle = .circular
            button.alignment = .center
//            button.cell?.font = NSFont.init(name: "<#T##String#>", size: 0)
            break
        case TableViewIdentifier.from:
            button.isBordered = false

        case TableViewIdentifier.manager:
            button.isBordered = false

        default:
            break
        }
    }
}

//button.imagePosition = .imageOnly
//button.setButtonType(.pushOnPushOff)
extension ButtonTableViewCell {
    private func installSubviews() {
        button = NSButton.init()
        button.target = self
//        button.image = NSImage.init(named: "close_icon")
        button.action = #selector(buttonAction(sender:))
        button.isBordered = false
        button.bezelStyle = .regularSquare
        button.focusRingType = .none


        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
}

extension ButtonTableViewCell {
    @objc private func buttonAction(sender: NSButton) {
        self.block?(sender)
    }
}
