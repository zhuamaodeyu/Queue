//
//  AdministratorMenuView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

protocol AdministratorMenuViewDelegate: class {
    func menuView(_ menuView: AdministratorMenuView, didSelectRowAt indexPath: Int)
}
protocol AdministratorMenuViewDataSource: class {
    func numberOfSections(in menuView: AdministratorMenuView) -> Int
    func menuView(_ menuView: AdministratorMenuView, cellForRowAt indexPath: Int) -> NSView?
}

class AdministratorMenuView: NSScrollView {
    private var containerView: NSView = NSView.init()

    weak var delegate: AdministratorMenuViewDelegate?
    weak var dataSource: AdministratorMenuViewDataSource?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.hasVerticalRuler = false
        self.hasHorizontalRuler = false
        self.hasVerticalScroller = true
        self.hasHorizontalScroller = false
        self.autohidesScrollers = true
        self.autoresizesSubviews = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.documentView = self.containerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdministratorMenuView {
    func reloadData()  {

    }
}
