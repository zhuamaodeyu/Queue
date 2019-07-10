//
//  ManagerViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

private struct TableViewIdentifier {
    //名字
    static var name = NSUserInterfaceItemIdentifier.init("name")
    // 版本
    static var version = NSUserInterfaceItemIdentifier.init("version")
    // 是否二进制
    static var hasBinrary = NSUserInterfaceItemIdentifier.init("binrary")
    // 业务线
    static var from = NSUserInterfaceItemIdentifier.init("from")
    // 负责人
    static var manager = NSUserInterfaceItemIdentifier.init("manager")
    // 单侧测试
    static var test = NSUserInterfaceItemIdentifier.init("test")
    // 收藏
    static var collection = NSUserInterfaceItemIdentifier.init("collection")
    // 构建
    static var building = NSUserInterfaceItemIdentifier.init("building")
}

class ManagerViewController: NSViewController {

    private var topView: MainContentTopMenuView!
    private var tableView: NSTableView!
    private var scrollView: NSScrollView!
    private var splitView: NSSplitView!
    private var terminalView: TerminalView!


    private var dataSource: [ComponentModel] = []

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        testData()
        installSubviews()
        initSubviewConstaints()
    }
}

extension ManagerViewController {
    private func installSubviews() {
        topView = MainContentTopMenuView.init()
        view.addSubview(topView)

        tableView = NSTableView.init()
        tableView.headerView?.backgroundColor = NSColor.clear
        tableView.backgroundColor = NSColor.clear
        tableView.focusRingType = .none
        tableView.autoresizesSubviews = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowSizeStyle = .large
        tableView.gridStyleMask = [.solidHorizontalGridLineMask, .solidVerticalGridLineMask]
        tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        tableView.sizeLastColumnToFit()
        configTableView()


        scrollView = NSScrollView.init()
        scrollView.backgroundColor = NSColor.randomColor
        scrollView.documentView = tableView
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        splitView = NSSplitView.init()
        splitView.isVertical = false
        splitView.dividerStyle = .paneSplitter
        splitView.autoresizesSubviews = true
        splitView.backgroundColor = NSColor.clear
        splitView.delegate = self
        splitView.adjustSubviews()
        view.addSubview(splitView)

        terminalView = TerminalView.init()
        terminalView.autoresizesSubviews = true
        splitView.addSubview(scrollView)
        splitView.addSubview(terminalView)
    }

    private func initSubviewConstaints() {
        topView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(view)
            make.height.equalTo(80)
        }
        splitView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.right.left.equalTo(view)
        }
    }

}


extension ManagerViewController {
    private func configTableView() {
        let nameColumn = NSTableColumn.init(identifier: TableViewIdentifier.name)
        nameColumn.headerCell.alignment = .center
        nameColumn.title = "组件名称"
        nameColumn.width = 100
        nameColumn.minWidth = 80
        nameColumn.isEditable = false
        nameColumn.sizeToFit()

        nameColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(nameColumn)

        let versionColumn = NSTableColumn.init(identifier: TableViewIdentifier.version)
        versionColumn.headerCell.alignment = .center
        versionColumn.title = "当前版本"
        versionColumn.width = 100
        versionColumn.minWidth = 80
        versionColumn.isEditable = false
        versionColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(versionColumn)

        let binraryColumn = NSTableColumn.init(identifier: TableViewIdentifier.name)
        binraryColumn.headerCell.alignment = .center
        binraryColumn.title = "是否支持二进制"
        binraryColumn.width = 100
        binraryColumn.minWidth = 80
        binraryColumn.isEditable = false
        binraryColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(binraryColumn)

        let fromColumn = NSTableColumn.init(identifier: TableViewIdentifier.from)
        fromColumn.headerCell.alignment = .center
        fromColumn.title = "所属业务线"
        fromColumn.width = 100

        fromColumn.minWidth = 80
        fromColumn.isEditable = false
        fromColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(fromColumn)

        let managerColumn = NSTableColumn.init(identifier: TableViewIdentifier.manager)
        managerColumn.headerCell.alignment = .center
        managerColumn.title = "负责人"
        managerColumn.width = 100

        managerColumn.minWidth = 80
        managerColumn.isEditable = false
        managerColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(managerColumn)

        let testColumn = NSTableColumn.init(identifier: TableViewIdentifier.test)
        testColumn.headerCell.alignment = .center
        testColumn.title = "是否支持单侧"
        testColumn.width = 100

        testColumn.minWidth = 80
        testColumn.isEditable = false
        testColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(testColumn)

        let collectionColumn = NSTableColumn.init(identifier: TableViewIdentifier.collection)
        collectionColumn.headerCell.alignment = .center
        collectionColumn.title = "收藏"
        collectionColumn.width = 100

        collectionColumn.minWidth = 80
        collectionColumn.isEditable = false
        collectionColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(collectionColumn)

        let buildingColumn = NSTableColumn.init(identifier: TableViewIdentifier.building)
        buildingColumn.headerCell.alignment = .center
        buildingColumn.title = "构建"
        buildingColumn.width = 100

        buildingColumn.minWidth = 80
        buildingColumn.isEditable = false
        buildingColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(buildingColumn)
    }
}

extension ManagerViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return nil
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let _ = dataSource[row]
        var cell:NSView? = nil
        switch tableColumn?.identifier {
        case TableViewIdentifier.name:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.name, owner: self)
            if cell == nil {
                cell = NameTableViewCell.init()
                cell?.identifier = TableViewIdentifier.name
            }
            // set data

            break
        case TableViewIdentifier.version:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.version, owner: self)
            if cell == nil {
                cell = VersionTableViewCell.init()
                cell?.identifier = TableViewIdentifier.version
            }
            // set data
            break
        case TableViewIdentifier.hasBinrary:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.hasBinrary, owner: self)
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.hasBinrary
            }
            // set data
            break
        case TableViewIdentifier.from:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.from, owner: self)
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.from
            }
            // set data
            break
        case TableViewIdentifier.manager:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.name, owner: self)
            if cell == nil {
                cell = NameTableViewCell.init()
                cell?.identifier = TableViewIdentifier.name
            }
            // set data
            break
        case TableViewIdentifier.test:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.test, owner: self)
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.test
            }
            // set data
            break
        case TableViewIdentifier.collection:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.collection, owner: self)
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.collection
            }
            // set data
            break
        case TableViewIdentifier.building:
            cell = tableView.makeView(withIdentifier: TableViewIdentifier.building, owner: self)
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.building
            }
            // set data
            break
        default:
            break
        }
        return cell
    }
}


extension ManagerViewController : NSSplitViewDelegate {
//    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        if dividerIndex == 1 {
//            return 200
//        }
//        return 500
//    }
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
            return splitView.frame.height - 100
    }
}



extension ManagerViewController {
    private func testData() {
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
        dataSource.append(ComponentModel.init())
    }
}
