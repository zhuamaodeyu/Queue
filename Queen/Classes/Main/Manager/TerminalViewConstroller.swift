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

    private var autoScroll: Bool = false
    
}

extension TerminalViewConstroller {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoScroll = buttomToolView.autoScroll
    }
    override func viewDidLayout() {
        super.viewDidLayout()
        textView.frame = NSRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height - 40)
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


        scrollView = NSScrollView.init()
        scrollView.hasVerticalScroller = true
        textView = NSTextView.init(frame: .zero)
        textView.isEditable = false 
        textView.string = ""
        scrollView.documentView = textView

        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(buttomToolView.snp.top)
        }
    }
}

extension TerminalViewConstroller {
    func update(content: NSAttributedString)  {
        self.textView.textStorage?.append(content)
        if autoScroll {
            textView.scrollBottom()
        }
    }
}

extension TerminalViewConstroller: TerminalButtomToolViewDelegate {
    func toolView(view: TerminalButtomToolView, didSelect button: NSButton, type: TerminalButtomType) {
        switch type {
        case .autoScroll:
            self.autoScroll = (button.state == .on)
            break
        case .clear:
            self.textView.string = ""
            break
        default:
            break
        }
    }
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
