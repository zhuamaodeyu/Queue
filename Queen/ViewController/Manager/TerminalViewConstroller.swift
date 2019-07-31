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

    private var terminalTextViews:[String:SyntaxTextView] = [:]
    private var currentTextViewId:String?

    private let menuListView: TerminalPopUpButton = {
        let button = TerminalPopUpButton.init()
        button.target = self as AnyObject
        button.action = #selector(menuListViewAction(_:))
        button.addItems(withTitles: ["测试1","测试2","测试3","测试4","测试5","测试6"])
        return button
    }()

    private let welcomeLabel: NSTextField = {
        let label = NSTextField.init()
        label.placeholderString = "欢迎使用 Queue"
        label.font = NSFont.systemFont(ofSize: 28)
        label.isBordered = false
        label.drawsBackground = false
        label.alignment = .left
        label.focusRingType = .none
        label.isSelectable = false
        label.isEditable = false
        return label
    }()

    override func loadView() {
        self.view = NSView.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
    }
}

extension TerminalViewConstroller {
    func installSubviews()  {
        if currentTextViewId != nil || self.view.subviews.contains(welcomeLabel) {
            return
        }
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }

        view.addSubview(menuListView)
        menuListView.snp.makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(50)
            make.width.equalTo(100)
        }

    }


    func terminalView(tag: String?) -> SyntaxTextView? {
        guard let tag = tag, !tag.isEmpty else {
            return nil
        }
        if Array(terminalTextViews.keys).contains(tag) {
            return terminalTextViews[tag]
        }
        let terminalView = SyntaxTextView.init()
        terminalView.contentTextView.isEditable = false
        terminalView.backgroundColor = NSColor.clear
        terminalView.scrollView.hasVerticalScroller = false
        terminalView.scrollView.hasHorizontalScroller = false
        terminalView.frame = self.view.bounds
        terminalTextViews.updateValue(terminalView, forKey: tag)
        return terminalView
    }
}

extension TerminalViewConstroller {
    @objc private func menuListViewAction(_ sender:NSPopUpButton) {

    }
}


extension TerminalViewConstroller {
    func updateContent(type: String?, content: NSAttributedString?)  {
        guard let content = content, let terminalView = terminalView(tag: type) else {
            return
        }
        terminalView.insertText(content.string)
        if currentTextViewId == nil {
            view.addSubview(terminalView, positioned: .below, relativeTo: menuListView)
            self.currentTextViewId = type
        }
    }
}



extension TerminalViewConstroller: SyntaxTextViewDelegate {
    class MyLexer: Lexer {
        func getSavannaTokens(input: String) -> [Token] {
            return []
        }
    }

    func didChangeText(_ syntaxTextView: SyntaxTextView) {

    }

    func didChangeSelectedRange(_ syntaxTextView: SyntaxTextView, selectedRange: NSRange) {

    }

    func lexerForSource(_ source: String) -> Lexer {
        return MyLexer.init()
    }
}
