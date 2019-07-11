//
//  TerminalView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/9.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class TerminalView: NSView {

    private var scrollView: NSScrollView!
    private var textView: NSTextView!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
        installSubviewConstaints()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.backgroundColor = NSColor.randomColor
        // Drawing code here.
    }
    
}

extension TerminalView {
    private func installSubviews() {
        textView = NSTextView.init()
        textView.delegate  = self
        textView.isEditable = false
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.textContainer?.containerSize = NSSize.init(width: Int.max, height:  Int.max)
        textView.textContainer?.widthTracksTextView = true

        textView.backgroundColor = NSColor.red
        textView.scrollToEndOfDocument(self)

        scrollView = NSScrollView.init()
        scrollView.hasVerticalScroller =  true 
        scrollView.hasHorizontalScroller = false
        scrollView.focusRingType = .none
        scrollView.borderType = .noBorder
        scrollView.scrollerKnobStyle = .dark
        scrollView.scrollerStyle = .legacy
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = textView

        self.addSubview(scrollView)
    }

    private func installSubviewConstaints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        textView.snp.makeConstraints { (make) in
            make.width.equalTo(scrollView)
        }
    }
}


extension TerminalView : NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        textView.scrollToEndOfDocument(nil)
    }
}
