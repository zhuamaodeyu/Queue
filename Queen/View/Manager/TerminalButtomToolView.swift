//
//  TerminalButtomToolView.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit

protocol TerminalButtomToolViewDelegate:class {

}

class TerminalButtomToolView: NSView {
    weak var delegate: TerminalButtomToolViewDelegate?

    private var closeButton: NSButton!
    private var autoScrollButton: NSButton!
    private var clearButton: NSButton!
    private let menuListView: TerminalPopUpButton = {
        let button = TerminalPopUpButton.init()
        let cell  = button.cell as? NSMenuItemCell
        button.bezelStyle = .texturedRounded
        button.target = self as AnyObject
        button.action = #selector(menuListViewAction(_:))
        button.addItems(withTitles: ["测试1","测试2","测试3","测试4","测试5","测试6"])
        return button
    }()


    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.backgroundColor = NSColor.systemBrown
        installSubviews()
        initSubviewsConstaints()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TerminalButtomToolView {
    private func installSubviews() {
        closeButton = NSButton.init(title: "Close", target: self, action: #selector(buttonAction(sender:)))
        closeButton.sizeToFit()
        self.addSubview(closeButton)

        autoScrollButton = NSButton.init(checkboxWithTitle: "Auto Scroll", target: self, action: #selector(buttonAction(sender:)))
        autoScrollButton.sizeToFit()
        self.addSubview(autoScrollButton)

        clearButton = NSButton.init(title: "Clear", target: self, action: #selector(buttonAction(sender:)))
        clearButton.sizeToFit()
        self.addSubview(clearButton)


        self.addSubview(menuListView)

    }

    private func initSubviewsConstaints()  {
        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(50)
        }
        autoScrollButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(clearButton.snp.left).offset(-10)
        }
        clearButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
        menuListView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(autoScrollButton.snp.left).offset(-50)
        }
    }
}


// MARK: - Action
extension TerminalButtomToolView {
    @objc private func buttonAction(sender: NSButton) {

    }

    @objc private func menuListViewAction(_ sender:NSPopUpButton) {

    }
}
