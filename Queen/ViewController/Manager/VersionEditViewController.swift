//
//  VersionEditViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/12.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

enum VersionType {
    case tag
    case commit
    case branch
    case none
}

struct VersionEditModel {
    var segmentControlIndex:Int
    var type:VersionType
    var address: String
    var version: String
    var title: String = ""
    var descMessage: String = ""

    init(segmentControlIndex:Int = 0, type:VersionType = .none,address: String = "", version: String = "",title: String = "",descMessage: String = "" ) {
        self.segmentControlIndex = segmentControlIndex
        self.type = type
        self.address = address
        self.version = version
        self.title = title
        self.descMessage = descMessage
    }
}

private let defaultTitleString = "dnakgndakngkdnakg"
private let defaultDescMessageString = "xnakgnknakga"
class VersionEditViewController: NSViewController {

    private var segmentControl: NSSegmentedControl!
    private var titleLabel: NSTextField!

    private var wayLabel: NSTextField!
    private var tagRadioButton: NSButton!
    private var branchRadioButton: NSButton!
    private var commitRadioButton: NSButton!

    private var addressLabel: NSTextField!
    private var addressTextField: NSTextField!
    private var addressSelectButton: NSButton!

    private var versionLabel: NSTextField!
    private var versionComboBox: NSComboBox!

    private var descMessageLabel: NSTextField!

    private var cancelButton: NSButton!
    private var enterButton:NSButton!


    private var segmentControlSelectIndex:Int = 0
    private var waySelectIndex:Int = -1
    private var address:String?
    private var version: String?
    private var type: VersionType = .none


    private var model: VersionEditModel = VersionEditModel.init()
    private var block:((_ model: VersionEditModel) -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        configSubviews()
        installSubviewConstaints()
    }
}

extension VersionEditViewController {
    func config(model: VersionEditModel, complation:@escaping ((_ model: VersionEditModel) -> Void)) {
        self.model = model
        self.block = complation
        configSubviews()
    }
}


extension VersionEditViewController {
    private func  installSubviews() {
        segmentControl = NSSegmentedControl.init(labels: ["远端配置","本地配置"], trackingMode: .selectOne, target: self, action: #selector(segmentControlAction(sender:)))
        segmentControl.sizeToFit()
        view.addSubview(segmentControl)

        titleLabel = NSTextField.init()
        titleLabel.stringValue = ""
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        titleLabel.isBordered = false
        titleLabel.maximumNumberOfLines = 1
        titleLabel.drawsBackground = false
        titleLabel.font = NSFont.systemFont(ofSize: 20.0)
        view.addSubview(titleLabel)

        wayLabel = NSTextField.init()
        wayLabel.stringValue = "集成方式:"
        wayLabel.isEditable = false
        wayLabel.isSelectable = false
        wayLabel.isBordered = false
        wayLabel.maximumNumberOfLines = 1
        wayLabel.drawsBackground = false
        wayLabel.font = NSFont.systemFont(ofSize: 15.0)
        view.addSubview(wayLabel)

        tagRadioButton = NSButton.init(radioButtonWithTitle: "Tag", target: self, action: #selector(radioButtonAction(sender:)))
        tagRadioButton.sizeToFit()
        view.addSubview(tagRadioButton)

        branchRadioButton = NSButton.init(radioButtonWithTitle: "Branch", target: self, action: #selector(radioButtonAction(sender:)))
        branchRadioButton.sizeToFit()
        view.addSubview(branchRadioButton)

        commitRadioButton = NSButton.init(radioButtonWithTitle: "Commit", target: self, action: #selector(radioButtonAction(sender:)))
        commitRadioButton.sizeToFit()
        view.addSubview(commitRadioButton)

        addressLabel = NSTextField.init()
        addressLabel.stringValue = "仓库地址:"
        addressLabel.sizeToFit()
        addressLabel.isEditable = false
        addressLabel.isSelectable = false
        addressLabel.isBordered = false
        addressLabel.drawsBackground = false
        addressLabel.maximumNumberOfLines = 1
        addressLabel.font = NSFont.systemFont(ofSize: 15.0)
        // 抗拉伸
        addressLabel.setContentHuggingPriority(.required, for: .horizontal)
        // 抗k压缩
//        addressLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        view.addSubview(addressLabel)

        addressTextField = NSTextField.init()
        addressTextField.alignment = .justified
        cell?.drawsBackground = true
        addressTextField.placeholderString = "请输入仓库地址"
        addressTextField.isBordered = true
        addressTextField.delegate = self
        addressTextField.isEditable = true
        addressTextField.maximumNumberOfLines = 1
        // 不设置字体，导致不可编辑
//        addressTextField.font = NSFont.init(name: "", size: 15.0)
        view.addSubview(addressTextField)

        addressSelectButton = NSButton.init()
        addressSelectButton.title = "请选择仓库地址"
        addressSelectButton.target = self
        addressSelectButton.action = #selector(addressSelectButtonAction(sender:))
        addressSelectButton.isHidden = true
        addressSelectButton.setButtonType(.momentaryLight)
        addressSelectButton.bezelStyle = .texturedRounded
        view.addSubview(addressSelectButton)

        versionLabel = NSTextField.init()
        versionLabel.stringValue = "版本信息:"
        versionLabel.isEditable = false
        versionLabel.isSelectable = false
        versionLabel.isBordered = false
        versionLabel.drawsBackground = false
        versionLabel.maximumNumberOfLines = 1
        versionLabel.font = NSFont.systemFont(ofSize: 15.0)
        view.addSubview(versionLabel)

        versionComboBox = NSComboBox.init()
        versionComboBox.isEditable = true
        versionComboBox.cell?.setAccessibilityEdited(true)
        versionComboBox.dataSource = self
        versionComboBox.isEditable = true
        versionComboBox.delegate = self
        view.addSubview(versionComboBox)


        descMessageLabel = NSTextField.init()
        descMessageLabel.isEditable = false
        descMessageLabel.isSelectable = false
        descMessageLabel.drawsBackground = false
        descMessageLabel.isBordered = false
        descMessageLabel.font = NSFont.systemFont(ofSize: 15.0)
        view.addSubview(descMessageLabel)

        cancelButton = NSButton.init(title: "Cancel", target: self, action: #selector(cancelButtonAction))
        cancelButton.sizeToFit()
        view.addSubview(cancelButton)

        enterButton = NSButton.init(title: "Enter", target: self, action: #selector(enterButtonAction(sender:)))
        enterButton.highlight(true)
        enterButton.sizeToFit()
        view.addSubview(enterButton)
    }
    private func installSubviewConstaints() {
        segmentControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.top.equalTo(segmentControl.snp.bottom).offset(50)
        }
        wayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        tagRadioButton.snp.makeConstraints { (make) in
            make.left.equalTo(wayLabel.snp.right).offset(20)
            make.centerY.equalTo(wayLabel)
        }
        commitRadioButton.snp.makeConstraints { (make) in
            make.left.equalTo(tagRadioButton.snp.right).offset(20)
            make.centerY.equalTo(wayLabel)
        }
        branchRadioButton.snp.makeConstraints { (make) in
            make.left.equalTo(commitRadioButton.snp.right).offset(20)
            make.centerY.equalTo(wayLabel)
        }
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(wayLabel)
            make.centerY.equalTo(addressTextField)
        }
        addressTextField.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel.snp.right).offset(20)
            make.top.equalTo(wayLabel.snp.bottom).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(25)
        }
        addressSelectButton.snp.makeConstraints { (make) in
            make.center.equalTo(addressTextField)
            make.size.equalTo(addressTextField)
        }

        versionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(wayLabel)
            make.centerY.equalTo(versionComboBox)
        }
        versionComboBox.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextField.snp.bottom).offset(20)
            make.left.equalTo(versionLabel.snp.right).offset(20)
            make.width.equalTo(200)
        }
        descMessageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(wayLabel)
            make.bottom.equalTo(cancelButton.snp.top).offset(-50)
        }
        cancelButton.snp.makeConstraints { (make) in
            make.right.equalTo(enterButton.snp.left).offset(-10)
            make.centerY.equalTo(enterButton)
        }
        enterButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-20)
        }

    }
}

extension VersionEditViewController {
    private func configSubviews() {

        // segmentControl
        if self.model.address.hasPrefix("http") || self.model.address.isEmpty {
            self.segmentControl.selectSegment(withTag: 0)
        }else {
            self.segmentControl.selectSegment(withTag: 1)
        }

        // title
        if self.model.title.isEmpty {
            self.model.title = defaultTitleString
        }

        self.titleLabel.stringValue = self.model.title

        // way
        switch self.model.type {
        case .tag:
            self.tagRadioButton.state = .on
        case .commit:
             self.commitRadioButton.state = .on
        case .branch:
             self.branchRadioButton.state = .on
        default:
            break
        }

        // address
        self.addressTextField.stringValue = self.model.address

        // version
        self.versionComboBox.stringValue = self.model.version

        // desc message
        if self.model.descMessage.isEmpty {
            self.model.descMessage = defaultDescMessageString
        }
        self.descMessageLabel.stringValue = self.model.descMessage
    }
}

// MARK: - Action
extension VersionEditViewController {
    @objc private func segmentControlAction(sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 1:
            self.addressSelectButton.isHidden = false
            self.addressTextField.isHidden = true
            break
        default:
            self.addressSelectButton.isHidden = true
            self.addressTextField.isHidden = false
            break
        }
        self.versionComboBox.stringValue = ""
    }

    @objc private func radioButtonAction(sender: NSButton) {
        self.versionComboBox.stringValue = ""
    }
    @objc private func cancelButtonAction() {
        self.view.window?.orderOut(nil)
        self.view.window!.endSheet(self.view.window!)
    }
    @objc private func enterButtonAction(sender: NSButton) {
        debugPrint("Enter Button Action")
    }
    @objc private func addressSelectButtonAction(sender:NSButton) {
        let openPanel = NSOpenPanel.init()
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowsMultipleSelection = false
        let result = openPanel.runModal()
        switch result.rawValue {
        case 0:
            debugPrint("Cancel")
            break
        case 1:
            debugPrint("OK  ==== \(String(describing: openPanel.url))")
            break
        default:
            break
        }
    }
}



// MARK: - NSComboBoxDelegate, NSComboBoxDataSource
extension VersionEditViewController: NSComboBoxDelegate, NSComboBoxDataSource {
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return 0
    }
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return ""
    }
    func comboBoxSelectionDidChange(_ notification: Notification) {

    }
}


extension VersionEditViewController : NSTextFieldDelegate {
    func controlTextDidEndEditing(_ obj: Notification) {
        debugPrint(" \(#function)")
    }
}


// MARK: - private
extension VersionEditViewController {
    // check address is git repo
    private func checkGit() {

    }
}
