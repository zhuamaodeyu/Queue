//
//  LeftMenuViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit

protocol MenuViewControllerDelegate:class {
    func leftMenuViewController(viewController: MenuViewController, tableView:NSTableView, didSelect row:Int)
}

struct MenuModel {
    var name: String
    var icon: String
}


class MenuViewController: NSViewController {

    public weak var delegate:MenuViewControllerDelegate?
    private var userNameLabel: NSTextField!
    private var userIconImageView: NSImageView!
    private var tableView: NSTableView!

    private var dataSource:[MenuModel] = []

    override func loadView() {
        self.view = NSView.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.append(MenuModel.init(name: "组件管理", icon: ""))
        dataSource.append(MenuModel.init(name: "网络配置", icon: ""))
        dataSource.append(MenuModel.init(name: "CI管理", icon: ""))
        dataSource.append(MenuModel.init(name: "文档", icon: ""))
        initSubviews()
        initSubviewConstaints()
        tableView.selectRowIndexes(IndexSet.init(arrayLiteral: 0), byExtendingSelection: true)
    }
}

extension MenuViewController {
    private func initSubviews() {
        userIconImageView = NSImageView.init()


        userNameLabel = NSTextField.init()
        userNameLabel.font = NSFont.systemFont(ofSize: 15.0)
        userNameLabel.isEditable = false
        userNameLabel.isBezeled = false
        userNameLabel.stringValue = "Queue"
        userNameLabel.sizeToFit()
        userNameLabel.drawsBackground = false
        userNameLabel.isSelectable = false
        userNameLabel.alignment = .center
        userNameLabel.isBordered = false

        tableView = NSTableView.init()
        tableView.backgroundColor = NSColor.clear
        tableView.focusRingType = .none
        tableView.autoresizesSubviews = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView = nil
        tableView.rowSizeStyle = .large
        tableView.target = self
        let column = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier.init(""))
        column.width = self.tableView.frame.width
        tableView.addTableColumn(column)


        view.addSubview(userIconImageView)
        view.addSubview(userNameLabel)
        view.addSubview(tableView)


        userIconImageView.backgroundColor  = NSColor.randomColor
        userNameLabel.backgroundColor = NSColor.randomColor


    }
    private func initSubviewConstaints() {
        userIconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(userIconImageView.snp.width)
        }
        userNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(userIconImageView.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-100)
            make.right.left.equalTo(view)
        }
    }
}


extension MenuViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init("LeftMenuViewController_cell"), owner: self) as? MenuTableViewCell
        if cell == nil {
            cell = MenuTableViewCell(frame: NSRect.zero)
            cell?.identifier = NSUserInterfaceItemIdentifier.init("LeftMenuViewController_cell")
        }
        cell?.objectValue = dataSource[row]
        return cell
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40
    }
    func tableViewSelectionDidChange(_ notification: Notification) {
        self.delegate?.leftMenuViewController(viewController: self, tableView: tableView, didSelect: tableView.selectedRow)
    }
}
