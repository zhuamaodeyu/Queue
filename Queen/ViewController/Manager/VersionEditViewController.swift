//
//  VersionEditViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/12.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class VersionEditViewController: NSViewController {

    private var segmentControl: NSSegmentedControl!
    private var titleLabel: NSTextField!

    private var wayLabel: NSTextField!
    private var tagRadioButton: NSButton!
    private var branchRadioButton: NSButton!
    private var commitRadioButton: NSButton!

    private var addressLabel: NSTextField!
    private var addressTextField: NSTextField!

    private var versionLabel: NSTextField!
    private var versionComboBox: NSComboBox!

    private var descMessageLabel: NSTextField!


    private var cancelButton: NSButton!
    private var enterButton:NSButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        installSubviewConstaints()
    }
    
}

extension VersionEditViewController {
    private func  installSubviews() {
        segmentControl = NSSegmentedControl.init(labels: ["远端配置","本地配置"], trackingMode: .selectOne, target: self, action: #selector(segmentControlAction(sender:)))
        segmentControl.sizeToFit()
        view.addSubview(segmentControl)

        titleLabel = NSTextField.init()
        titleLabel.isEditable = false
        titleLabel.isSelectable = true
        titleLabel.isBordered = false
        titleLabel.maximumNumberOfLines = 1
        titleLabel.font = NSFont.init(name: "", size: 20.0)
        view.addSubview(titleLabel)

        wayLabel = NSTextField.init()
        wayLabel.isEditable = false
        wayLabel.isSelectable = true
        wayLabel.isBordered = false
        wayLabel.maximumNumberOfLines = 1
        wayLabel.font = NSFont.init(name: "", size: 15.0)
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
        addressLabel.isEditable = false
        addressLabel.isSelectable = true
        addressLabel.isBordered = false
        addressLabel.maximumNumberOfLines = 1
        addressLabel.font = NSFont.init(name: "", size: 15.0)
        view.addSubview(addressLabel)

        addressTextField = NSTextField.init()
        addressTextField.isSelectable = true
        addressTextField.isBordered = false
        addressTextField.maximumNumberOfLines = 1
        addressTextField.font = NSFont.init(name: "", size: 15.0)
        view.addSubview(addressTextField)


        versionLabel = NSTextField.init()
        versionLabel.isEditable = false
        versionLabel.isSelectable = true
        versionLabel.isBordered = false
        versionLabel.maximumNumberOfLines = 1
        versionLabel.font = NSFont.init(name: "", size: 15.0)
        view.addSubview(versionLabel)

        versionComboBox = NSComboBox.init()
        versionComboBox.addItems(withObjectValues: [])
        versionComboBox.dataSource = self
        versionComboBox.delegate = self
        view.addSubview(versionComboBox)


        descMessageLabel = NSTextField.init()
        descMessageLabel.isEditable = false
        descMessageLabel.isSelectable = true
        descMessageLabel.isBordered = false
        descMessageLabel.font = NSFont.init(name: "", size: 15.0)
        view.addSubview(descMessageLabel)

        cancelButton = NSButton.init(title: "", target: self, action: #selector(cancelButtonAction))
        cancelButton.sizeToFit()
        view.addSubview(cancelButton)

        enterButton = NSButton.init(title: "", target: self, action: #selector(enterButtonAction))
        enterButton.sizeToFit()
        view.addSubview(enterButton)
    }
    private func installSubviewConstaints() {
        segmentControl.snp.makeConstraints { (make) in

        }
        titleLabel.snp.makeConstraints { (make) in

        }
        wayLabel.snp.makeConstraints { (make) in

        }
        [tagRadioButton, branchRadioButton, commitRadioButton]


        addressLabel.snp.makeConstraints { (make) in

        }
        addressTextField.snp.makeConstraints { (make) in

        }
        versionLabel.snp.makeConstraints { (make) in

        }
        versionComboBox.snp.makeConstraints { (make) in

        }
        cancelButton.snp.makeConstraints { (make) in

        }
        enterButton.snp.makeConstraints { (make) in
            
        }
    }
}

extension VersionEditViewController {

}

// MARK: - Action
extension VersionEditViewController {
    @objc private func segmentControlAction(sender: NSSegmentedControl) {

    }

    @objc private func radioButtonAction(sender: NSButton) {

    }
    @objc private func cancelButtonAction() {

    }
    @objc private func enterButtonAction() {

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

