//
//  LeftMenuViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit
import LeanCloud

protocol MenuViewControllerDelegate:class {
    func leftMenuViewController(viewController: MenuViewController, tableView:NSTableView?, didSelect type:MenuType)
}

struct MenuModel {
    var name: String
    var icon: String
    var unreadCount:Int = 0
}

enum MenuType:Int {
    case none = -1
    case podManager
    case CIManager
    case networkManager
    case build
    case document
    case sourceCache
    case buriedPoint
    case admin
}

enum MenuShowType {
    case all
    case onlyIcon
}

class MenuViewController: NSViewController {

    private struct AssociationKey {
        static var columnKey = NSUserInterfaceItemIdentifier.init("MenuViewController_column")
        static var cellKey = NSUserInterfaceItemIdentifier.init("LeftMenuViewController_cell")
    }

    public weak var delegate:MenuViewControllerDelegate?
    private var userNameLabel: NSTextField!
    private var userIconImageView: NSImageView!
    private var tableView: NSTableView!

    private var dataSource:[MenuModel] = []
    private var type: MenuShowType = .all {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func loadView() {
        self.view = NSView.init()
        initSubviews()
        initSubviewConstaints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
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
        let column = NSTableColumn.init(identifier: AssociationKey.columnKey)
        column.width = self.tableView.frame.width
        tableView.addTableColumn(column)

        view.addSubview(userIconImageView)
        view.addSubview(userNameLabel)
        view.addSubview(tableView)

        userIconImageView.backgroundColor  = NSColor.randomColor
    }
    private func initSubviewConstaints() {
        userIconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(80)
            make.width.greaterThanOrEqualTo(150)
            make.width.lessThanOrEqualTo(80)
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
        var cell = tableView.makeView(withIdentifier: AssociationKey.cellKey, owner: self) as? MenuTableViewCell
        if cell == nil {
            cell = MenuTableViewCell(frame: NSRect.zero)
            cell?.identifier = AssociationKey.cellKey
        }
        cell?.config(model: dataSource[row], type: type)
        return cell
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40
    }
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let type = MenuType.init(rawValue: tableView.selectedRow) {
            self.delegate?.leftMenuViewController(viewController: self, tableView: tableView, didSelect: type)
        }
    }
}


extension MenuViewController {
    private func initData() {
//        self.userIconImageView.image = LCApplication.default.currentUser
        self.userNameLabel.stringValue = LCApplication.default.currentUser?.username?.value ?? ""
        dataSource.append(MenuModel.init(name: "组件管理", icon: "", unreadCount: 0))
        dataSource.append(MenuModel.init(name: "网络配置", icon: "", unreadCount: 0))
        // 包括CI 管理和 本地构建
        dataSource.append(MenuModel.init(name: "构建", icon: "", unreadCount: 0))
        dataSource.append(MenuModel.init(name: "文档", icon: "", unreadCount: 0))
        // 二进制framework 下的缓存
        dataSource.append(MenuModel.init(name: "Source 缓存", icon: "", unreadCount: 0))
        dataSource.append(MenuModel.init(name:"埋点",icon: "",unreadCount: 0))
        #if DEBUG
             dataSource.append(MenuModel.init(name: "Administrator", icon: "", unreadCount: 0))
        #else
        if (LCApplication.default.currentUser as? UserEntity)?.master.boolValue ?? false {
            dataSource.append(MenuModel.init(name: "Administrator", icon: "", unreadCount: 0))
        }
        #endif
        self.tableView.reloadData()
    }
}
