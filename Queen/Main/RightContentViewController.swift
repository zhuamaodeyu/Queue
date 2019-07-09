//
//  RightContentViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class RightContentViewController: NSViewController {

    private var topView: MainContentTopMenuView!
    private var tableView: NSTableView!
    private var scrollView: NSScrollView!
    private var tableViewDelegate: ContentTableViewDataSource = ContentTableViewDataSource()

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = NSColor.randomColor
        installSubviews()
        initSubviewConstaints()
    }
    
}

extension RightContentViewController {
    private func installSubviews() {
        topView = MainContentTopMenuView.init()
        view.addSubview(topView)

        tableView = NSTableView.init()
        tableView.backgroundColor = NSColor.clear
        tableView.focusRingType = .none
        tableView.autoresizesSubviews = true
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDelegate
        tableView.headerView = nil
        tableView.rowSizeStyle = .large
        let column = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier.init("lie"))
        column.width = self.tableView.frame.width
        tableView.addTableColumn(column)


        scrollView = NSScrollView.init()
        scrollView.backgroundColor = NSColor.randomColor
        scrollView.documentView = tableView
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
    }

    private func initSubviewConstaints() {
        topView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(view)
            make.height.equalTo(80)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.right.left.equalTo(view)
        }
    }

}
