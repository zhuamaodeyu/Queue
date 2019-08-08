//
//  BuildingViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/10.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

private let BuildingManagerCellID = NSUserInterfaceItemIdentifier(rawValue: "BuildingManagerCellID")
class BuildingViewController: NSViewController {

    private var tableView: NSTableView!
    private var tableContainerView: NSScrollView!
    private var contentViewControllers:[BuildingTerminalManagerController] = []

    private var dataSource:[String] = []

    override func loadView() {
        self.view = NSView.init()
        installSubviews()
        self.dataSource.append("")
        self.dataSource.append("")
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BuildingViewController {
    private func installSubviews() {
        tableView = NSTableView.init()
        tableView.backgroundColor = NSColor.clear
        tableView.focusRingType = .none
        tableView.autoresizesSubviews = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView = nil
        tableView.rowSizeStyle = .large
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleAction(_:))
        let column = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier.init("lie"))
        column.width = self.tableView.frame.width
        tableView.addTableColumn(column)


        tableContainerView = NSScrollView.init()
        tableContainerView.backgroundColor = NSColor.clear
        tableContainerView.documentView = tableView
        tableContainerView.drawsBackground = false
        tableContainerView.hasVerticalScroller = false
        tableContainerView.autohidesScrollers = true
        tableContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableContainerView)

        tableContainerView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.view)
            make.width.equalTo(200)
        }
    }
}

extension BuildingViewController: NSTableViewDelegate {

    @objc private func tableViewDoubleAction(_ sender: NSTableView) {

    }


    /// 创建build
    @objc private func createNotification(_ sender: Notification) {
         // 1. 创建一个model 对象
        if contentViewControllers.count ==  0 {
            // 创建一个新的,添加进数组中
            let controller = BuildingTerminalManagerController.init()
            contentViewControllers.append(controller)
            self.view.addSubview(controller.view)
            self.children.append(controller)
        }else {
            let controller = BuildingTerminalManagerController.init()
            contentViewControllers.append(controller)
            self.children.removeAll()
            self.children.append(controller)

            let currentController = contentViewControllers[self.tableView.selectedRow]
            self.transition(from: currentController, to: controller, options: .slideRight, completionHandler: {

            })
        }
    }
}

extension BuildingViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return nil
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell = tableView.makeView(withIdentifier: BuildingManagerCellID, owner: self) as? BuildingManagerCell
        if cell == nil {
            cell = BuildingManagerCell.init()
            cell?.identifier = BuildingManagerCellID
        }
        return cell
    }
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
}


