//
//  WelcomeViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


private let CellIdentifier = "WelcomeViewController_cell"
class WelcomeViewController: NSViewController {

    private var closeButton: NSButton!
    private var iconImageView: NSImageView!
    private var titleLabel: NSTextField!
    private var versionLabel: NSTextField!
    private var launchButton: NSButton!
    private var tableView: NSTableView!
    private var tableContainerView: NSScrollView!
    private var leftContentView: NSView!
    private var rightContentView: NSVisualEffectView!

    private var createButton:WelcomeViewActionView!

    private var dataSource:[WelcomeWorkspaceModel] {
        return AppInfo.shared.config.workspaceList
    }

    private var podRepoCoordinator = PodRepoCoordinator.init()


}

// MARK: system function 
extension WelcomeViewController {
    override func loadView() {
        super.loadView()
        initSubviews()
        subviewsConstains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadView()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        checkShowAddSources()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        if leftContentView.trackingAreas.count <= 0 {
            leftContentView.addTrackingArea(NSTrackingArea.init(rect: leftContentView.bounds, options: [.mouseEnteredAndExited ,.activeInActiveApp], owner: self, userInfo: nil))
        }
        if closeButton.trackingAreas.count <= 0 {
            closeButton.addTrackingArea(NSTrackingArea.init(rect: closeButton.bounds, options: [.mouseEnteredAndExited ,.activeInActiveApp], owner: self, userInfo: nil))
        }
    }

}

// MARK: - UI
extension WelcomeViewController {
    private func initSubviews() {
        leftContentView = NSView.init()
        view.addSubview(leftContentView)

        closeButton = NSButton.init()
        closeButton.target = self
        closeButton.image = NSImage.init(named: "close_icon")
        closeButton.action = #selector(closeButtonAction)
        closeButton.isBordered = false
        closeButton.bezelStyle = .regularSquare
        closeButton.imagePosition = .imageOnly
        closeButton.focusRingType = .none
        closeButton.setButtonType(.pushOnPushOff)
        leftContentView.addSubview(closeButton)

        iconImageView = NSImageView.init()
        iconImageView.imageScaling = .scaleAxesIndependently
        leftContentView.addSubview(iconImageView)

        titleLabel = NSTextField.init()

        titleLabel.font = NSFont.systemFont(ofSize: 28.0)
        titleLabel.isEditable = false
        titleLabel.isBezeled = false
        titleLabel.stringValue = "Welcome to Queue"
        titleLabel.sizeToFit()
        titleLabel.drawsBackground = false
        titleLabel.isSelectable = false
        titleLabel.alignment = .center
        titleLabel.isBordered = false
        leftContentView.addSubview(titleLabel)

        versionLabel = NSTextField.init()
        versionLabel.font = NSFont.systemFont(ofSize: 12.0)
        versionLabel.textColor = NSColor.withHex(hexString: "")
        versionLabel.isEditable = false
        versionLabel.isBezeled = false
        versionLabel.isSelectable = false
        versionLabel.drawsBackground = false
        versionLabel.stringValue = "Version 0.0.1"
        versionLabel.isBordered = false
        versionLabel.alignment = .center
        versionLabel.sizeToFit()
        leftContentView.addSubview(versionLabel)

        launchButton = NSButton.init()
        launchButton.setButtonType(.switch)
        launchButton.title = "Show this window when Queue launchs"
        launchButton.target = self
        launchButton.action = #selector(launchButtonAction(sender:))
        leftContentView.addSubview(launchButton)

        createButton = WelcomeViewActionView.init()
        createButton.updateUI(image: NSImage.init(named: NSImage.Name.init("project"))!, title: "打开新项目", desc: "打开一个Xcode Project 项目")
        createButton.target = self
        createButton.action = #selector(createButtonAction)
        leftContentView.addSubview(createButton)


        rightContentView = NSVisualEffectView.init()
        rightContentView.wantsLayer = true
        view.addSubview(rightContentView)


        tableView = NSTableView.init()
        tableView.backgroundColor = NSColor.clear
        tableView.focusRingType = .none
        tableView.autoresizesSubviews = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView = nil
        tableView.rowSizeStyle = .large
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleAction(sender:))
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
        rightContentView.addSubview(tableContainerView)
        
        iconImageView.backgroundColor = NSColor.randomColor
    }

    private func subviewsConstains() {

        leftContentView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(view)
            make.right.equalTo(tableView.snp.left)
        }
        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(leftContentView).offset(10)
            make.top.equalTo(leftContentView).offset(10)
            make.size.equalTo(CGSize.init(width: 10, height: 10))
        }
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftContentView)
            make.size.equalTo(CGSize.init(width: 80, height: 80))
            make.bottom.equalTo(leftContentView.snp.centerY).offset(-30)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftContentView)
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftContentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        launchButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftContentView)
            make.bottom.equalTo(leftContentView.snp.bottom).offset(-10)
        }

        createButton.snp.makeConstraints { (make) in
            make.left.equalTo(leftContentView).offset(20)
            make.right.equalTo(leftContentView).offset(-20)
            make.bottom.equalTo(launchButton.snp.top).offset(-40)
            make.height.equalTo(80)
        }

        rightContentView.snp.makeConstraints { (make) in
            make.top.right.equalTo(view)
            make.height.equalTo(view)
            make.width.equalTo(240)
        }

        tableContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }

    private func reloadView() {
        self.tableView.wantsLayer = true
        if dataSource.count == 0 {
            self.tableView.isHidden =  true
        }else {
            self.tableView.isHidden = false
            
            self.tableView.reloadData()
        }
    }

    private func checkShowAddSources() {
        let source = newSources()
        if source.count >= 0 {
            NSAlert.alert(stye: .informational, message: "提示", information: "发现新的Spec源，是否安装?", button: ["取消","安装"]) { (result) in
                debugPrint("安装新的源")
            }
        }
    }
}


// MARK: - mouse Action
extension WelcomeViewController {
    override func mouseEntered(with event: NSEvent) {
        if closeButton.mouseInView() {

            return
        }
        launchButton.wantsLayer = true
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.2
            launchButton.animator().alphaValue = 1.0
        }, completionHandler: {

        })
    }
    override func mouseExited(with event: NSEvent) {
        if closeButton.mouseInView() {
            return
        }
        if leftContentView?.alphaValue ?? 0.0  == 1.0 {
            launchButton.wantsLayer = true
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.2
                launchButton.animator().alphaValue = 0
            }, completionHandler:{
                
            })
        }
    }
}


// MARK: - Data
extension WelcomeViewController {

    /// 获取需要添加的sources
    ///
    /// - Returns: sources
    private func newSources() ->[SpecSourceEntity] {
        // 1. 判断是否需要添加 sources
        let localSourcesHost = Cocoapods.instance.sources.map { (m) -> String in
            return m.host
        }
        let needAddSources = EntitysDataManager.instance.specSources.filter { (entity) -> Bool in
            !localSourcesHost.contains(entity.host?.stringValue ?? "")
        }
        return needAddSources
    }
}


// MARK: - Action
extension WelcomeViewController {
    @objc private func closeButtonAction() {
        view.window?.close()

    }
    @objc private func launchButtonAction(sender: NSButton) {

        
    }
    @objc private func tableViewDoubleAction(sender:NSTableView) {
        guard let model = self.dataSource[safe: sender.selectedRow] else {
            return
        }
        DocumentController.shared.openDocument(withContentsOf:URL.init(fileURLWithPath: model.address ?? ""), display: true) { (document, result, error) in
            if let _ = error {
                return
            }
            self.view.window?.close()
        }
    }
    @objc private func createButtonAction() {
        let openPanel = NSOpenPanel.init()
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowedFileTypes = ["queue"]
        openPanel.allowsMultipleSelection = false
        let result = openPanel.runModal()
        switch result.rawValue {
        case 0:
            break
        case 1:
            if let u = openPanel.url, let result = WorkspaceManager.initizale(path: u.path) {
                // enter document window
                DocumentController.shared.openDocument(withContentsOf: result.url, display: true) { (document , res, error) in
                    (document as? Document)?.newCreate = result.newCreate
                    WorkspaceManager.insert(workspcace: WelcomeWorkspaceModel.init(file: result.url))
                     self.view.window?.close()
                }
            }
            break
        default:
            break
        }
    }
}


// MARK: - NSTableViewDelegate, NSTableViewDataSource
extension WelcomeViewController : NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return nil
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(CellIdentifier), owner: self) as? WelcomeTableViewCell
        if cell == nil {
            cell = WelcomeTableViewCell.init()
            cell?.identifier = NSUserInterfaceItemIdentifier(rawValue: CellIdentifier)
        }
        let model = dataSource[row]
        cell?.updateUI(image: NSImage.init(named: model.image ?? "")!, title: model.projectName ?? "", desc: model.desc ?? "")
        return cell
    }
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
}
