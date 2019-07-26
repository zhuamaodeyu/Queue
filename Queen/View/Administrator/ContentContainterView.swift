//
//  ContentContainterView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

protocol ContentContainterViewDelegate:class {
    func contentContainterView(_ containterView: ContentContainterView,with type:AdministratorActionType, submitButtonClick model:ContentContaiterViewModel)
}

struct ContentContaiterViewModel {

}

class ContentContainterView: NSScrollView {
    private var containerView: NSView = NSView.init()


    private var type:AdministratorActionType = .none


    weak var delegate: ContentContainterViewDelegate?
    // model
    private var model: ContentContaiterViewModel = ContentContaiterViewModel.init()


    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.containerView.backgroundColor = NSColor.randomColor
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

extension ContentContainterView {
    func config() {
        
    }
}

extension ContentContainterView {
    func reloadData(with type:AdministratorActionType)  {
        self.type = type
        switch type {
        case .user:
            break
        case .team:
            break
        case .spec:
            break
        default:
            break
        }
    }
}
