//
//  ManagerViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


struct TableViewIdentifier {
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
    private var terminalView: SyntaxTextView!


    private var dataSource: [ComponentModel] = []

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        initSubviewConstaints()
        testData()
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
        tableView.selectionHighlightStyle = .none
        tableView.gridStyleMask = [.solidHorizontalGridLineMask, .solidVerticalGridLineMask]
        tableView.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle
        tableView.sizeLastColumnToFit()
        configTableView()


        scrollView = NSScrollView.init()
        scrollView.backgroundColor = NSColor.clear
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

        terminalView = SyntaxTextView.init()
        terminalView.delegate = self
        terminalView.contentTextView.isEditable = false
        terminalView.backgroundColor = NSColor.clear
        terminalView.scrollView.hasVerticalScroller = false
        terminalView.scrollView.hasHorizontalScroller = false
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
        nameColumn.width = 200
        nameColumn.minWidth = 150
        nameColumn.isEditable = false
        nameColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(nameColumn)

        let versionColumn = NSTableColumn.init(identifier: TableViewIdentifier.version)
        versionColumn.headerCell.alignment = .center
        versionColumn.title = "当前版本"
        versionColumn.width = 280
        versionColumn.minWidth = 250
        versionColumn.maxWidth = 280
        versionColumn.isEditable = false
        versionColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(versionColumn)

        let binraryColumn = NSTableColumn.init(identifier: TableViewIdentifier.hasBinrary)
        binraryColumn.headerCell.alignment = .center
        binraryColumn.title = "是否支持二进制"
        binraryColumn.width = 100
        binraryColumn.isEditable = false
        binraryColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(binraryColumn)

        let fromColumn = NSTableColumn.init(identifier: TableViewIdentifier.from)
        fromColumn.headerCell.alignment = .center
        fromColumn.title = "所属业务线"
        fromColumn.width = 100
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
        testColumn.title = "支持单侧"
        testColumn.width = 100
        testColumn.minWidth = 100
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
        let model = dataSource[row]
        switch tableColumn?.identifier {
        case TableViewIdentifier.name:
           var cell = tableView.makeView(withIdentifier: TableViewIdentifier.name, owner: self) as? NameTableViewCell
            if cell == nil {
                cell = NameTableViewCell.init()
                cell?.identifier = TableViewIdentifier.name
            }
            // set data
           cell?.config(name: model.name, document: true)
           return cell
        case TableViewIdentifier.version:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.version, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.version
            }

            // set data
            cell?.config(image: nil, title: model.version, type: TableViewIdentifier.version, complation: { [weak self](button) in
                guard let windowController = NSStoryboard.windowController(name: "VersionEditWindowController", storyboard: "MainUI") as? VersionEditWindowController else {
                    return
                }
                (windowController.contentViewController as? VersionEditViewController)?.config(model: VersionEditModel.init(segmentControlIndex: 0, type: .tag, address: "http://xxxxnkdsnakg.get", version: "0.1.0"), complation: { (model) in

                })
                self?.view.window?.beginSheet(windowController.window!, completionHandler: { (modeResponse) in

                })
            })
            return cell
        case TableViewIdentifier.hasBinrary:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.hasBinrary, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.hasBinrary
            }
            // set data
            cell?.config(image: nil, title: "二进制", type: TableViewIdentifier.hasBinrary, complation: { (button ) in

            })
            return cell
        case TableViewIdentifier.from:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.from, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.from
            }
            // set data
            cell?.config(image: nil, title: "", type: TableViewIdentifier.from, complation: { (button) in

            })
            return cell
        case TableViewIdentifier.manager:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.name, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.name
            }
            // set data
            cell?.config(image: nil, title: model.manager, type: TableViewIdentifier.manager, complation: { (button) in
                
            })
            return cell
        case TableViewIdentifier.test:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.test, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.test
            }
            // set data
            cell?.config(image: nil, title: "是否支持单侧", type: TableViewIdentifier.test, complation: { (button) in
                
            })
            return cell
        case TableViewIdentifier.collection:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.collection, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.collection
            }
            // set data
            cell?.config(image: nil, title: nil , type: TableViewIdentifier.collection, complation: { (button) in

            })
            return cell
        case TableViewIdentifier.building:
            var cell = tableView.makeView(withIdentifier: TableViewIdentifier.building, owner: self) as? ButtonTableViewCell
            if cell == nil {
                cell = ButtonTableViewCell.init()
                cell?.identifier = TableViewIdentifier.building
            }
            // set data
            cell?.config(image: nil, title: "Build", type: TableViewIdentifier.building, complation: { (button) in
                
            })
            return cell
        default:
            break
        }
        return nil
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

extension ManagerViewController: SyntaxTextViewDelegate {

    func didChangeText(_ syntaxTextView: SyntaxTextView) {

    }

    func didChangeSelectedRange(_ syntaxTextView: SyntaxTextView, selectedRange: NSRange) {

    }

    func lexerForSource(_ source: String) -> Lexer {
        return MyLexer.init()
    }
}

class MyLexer: Lexer {
    func getSavannaTokens(input: String) -> [Token] {
        return []
    }
}




extension ManagerViewController {
    private func testData() {
        let component1 = ComponentModel.init(name: "授信",
                                             version: "0.1.1",
                                             binaray: false,
                                             from: "项目2线",
                                             manager: "张三",
                                             test: false,
                                             collection: false,
                                             building: false)
        dataSource.append(component1)

        self.tableView.reloadData()

        terminalView.text = """
        This is an example of SavannaKit.
        This example highlights words that are longer than 6 characters in red.
        """
    }
}

extension ManagerViewController {
    // module version window
    private func popVersionWindow() {
        let notification = NSUserNotification()
        notification.identifier = "unique-id"
        notification.title = "Hello"
        notification.subtitle = "How are you?"
        notification.informativeText = "This is a test"
        notification.soundName = NSUserNotificationDefaultSoundName
//        notification.contentImage = NSImage(contentsOf: NSURL(string: "https://placehold.it/300")! as URL)
        // Manually display the notification

        // 延迟10 🐱 scheduleNotification 发送通知
        notification.deliveryDate = NSDate(timeIntervalSinceNow: 10) as Date
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.scheduleNotification(notification)
//        notificationCenter.deliver(notification)
        // 默认情况下 


    }
}
