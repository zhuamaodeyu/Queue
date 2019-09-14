//
//  TerminalViewConstroller.swift
//  Queen
//
//  Created by 聂子 on 2019/7/30.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

protocol TerminalViewConstrollerDelegate:class {

}

class TerminalViewConstroller: NSViewController {
    weak var delegate: TerminalViewConstrollerDelegate?

    private var textView: NSTextView!
    private var scrollView: NSScrollView!

    private var buttomToolView:TerminalButtomToolView = TerminalButtomToolView.init()


    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension TerminalViewConstroller {
    func installSubviews()  {

        view.addSubview(buttomToolView)
        buttomToolView.delegate = self
        buttomToolView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.right.bottom.equalTo(view)
        }

        //
        scrollView = NSScrollView.init()
        textView = NSTextView.init()

        scrollView.documentView = textView

        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(buttomToolView.snp.top)
        }
    }
}

extension TerminalViewConstroller {
    func update(content: NSAttributedString)  {

    }
}

extension TerminalViewConstroller: TerminalButtomToolViewDelegate {

}



//scrollView = NSScrollView.init()
//scrollView.backgroundColor = NSColor.clear
//scrollView.drawsBackground = false
//scrollView.hasVerticalScroller = false
//scrollView.autohidesScrollers = true
//scrollView.translatesAutoresizingMaskIntoConstraints = false
//scrollView.hasVerticalScroller = false
//scrollView.hasHorizontalScroller = false
//
//
//
//let textContainer = NSTextContainer.init(size: CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude))
//textContainer.heightTracksTextView = true
//textContainer.heightTracksTextView = false
//textContainer.widthTracksTextView = true
//
//let layoutManager = NSLayoutManager()
//layoutManager.addTextContainer(textContainer)
//
//terminalView = NSTextView.init(frame: .zero, textContainer: textContainer)
//terminalView.isEditable = false
//terminalView.translatesAutoresizingMaskIntoConstraints = false
//terminalView.maxSize = CGSize.init(width: CGFloat.infinity, height: CGFloat.infinity)
//terminalView.backgroundColor = NSColor.clear
//terminalView.textContainer?.containerSize = CGSize.init(width: CGFloat.infinity, height: CGFloat.infinity)
//terminalView.textContainer?.widthTracksTextView = true
//terminalView.isHorizontallyResizable = true
//terminalView.isVerticallyResizable  = true
//terminalView.backgroundColor = NSColor.red
//terminalView.text = "dsangnakngdknaskgndkasngkdasnkgndakgnkangkangknakgnkan"
//terminalView.maxSize = NSSize(width: 0, height: CGFloat.greatestFiniteMagnitude)
//terminalView.isRichText = false
//terminalView.importsGraphics = false
//
//
//scrollView.documentView = terminalView
