//
//  CIManagerViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/10.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

private let CIManagerViewControllerCellID = NSUserInterfaceItemIdentifier.init("CIManagerViewControllerCellID")
class CIManagerViewController: NSViewController {

    private var tableView: NSTableView!
    private var tableContainerView: NSScrollView!
    private var contentViewController = CIStatusViewController.init()

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
extension CIManagerViewController : MainSubViewControllerProtocol{
    var type: MenuType {
        return .CIManager
    }
}

extension CIManagerViewController {
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
        self.addChild(self.contentViewController)
        self.view.addSubview(self.contentViewController.view)
        self.contentViewController.view.snp.makeConstraints { (make) in
            make.left.equalTo(tableContainerView.snp.right)
            make.top.bottom.right.equalTo(self.view)
        }
    }
}

extension CIManagerViewController: NSTableViewDelegate {

    @objc private func tableViewDoubleAction(_ sender: NSTableView) {

    }
}

extension CIManagerViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return nil
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell = tableView.makeView(withIdentifier: CIManagerViewControllerCellID, owner: self) as? CIManagerViewCell
        if cell == nil {
            cell = CIManagerViewCell.init()
            cell?.identifier = CIManagerViewControllerCellID
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

