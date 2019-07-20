//
//  CIStatusViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/20.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class CIStatusViewController: NSViewController {

    private var contentView: NSView = NSView.init()

    override func loadView() {

        let scrollView = NSScrollView.init()
        scrollView.backgroundColor = NSColor.clear
        scrollView.documentView = self.contentView
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalRuler = true
        scrollView.hasHorizontalRuler =  true
        scrollView.autohidesScrollers = true
        scrollView.scrollerStyle = .overlay
        scrollView.scrollerKnobStyle = .dark
        scrollView.horizontalScrollElasticity = .automatic
        scrollView.verticalScrollElasticity = .automatic
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view = scrollView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        contentView.backgroundColor = NSColor.randomColor
        (self.view as? NSScrollView)?.scrollToTop()
        self.contentView.frame = CGRect.init(x: 0, y: 0, width: 5000, height: 1000)
    }


    override func viewDidAppear() {
        super.viewDidAppear()
        debugPrint("")
    }
}
extension CIStatusViewController {
    private func installSubviews() {
    }
}
extension CIStatusViewController {
    func config() {
        debugPrint("config")
    }
}
