//
//  MainContentTopMenuView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/9.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


enum TopViewButtonType {
    case reload
    case build
    case stop
    case translation
    case pod_install
    case pod_update
    case pod_searach
    case xcode
    case vscode
    case floder

    case mapping
}



class MainContentTopMenuView: NSView {

    // 刷新按钮
    private var reloadButton: NSButton!

    // build 命令
    private var buildButton: NSButton!
    private var stopButton: NSButton!
    private var translationButton: NSButton!

    private var mappingButton: NSButton!

    // ================= pod
    private var podInstallButton: NSButton!
    private var podUpdateButton: NSButton!
    private var podSearchButton: NSButton!

    //==================== 右边
    // xcode 打开
    private var xcodeButton: NSButton!
    // vs code 打开配置文件
    private var vsCodeButton: NSButton!
    // 📂
    private var folderButton: NSButton!

    // 页面样式  上下 左右
    private var segmentControl: NSSegmentedControl!

    // =======================
    // search
    private var checkTypeButton: NSPopUpButton!
    private var searchTextField: NSSearchField!


    private var complation:((_ sender: NSView, _ type:TopViewButtonType)-> Void)?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        installSubviews()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
}

extension MainContentTopMenuView {
    func config( complation:((_ sender: NSView, _ type:TopViewButtonType)-> Void)? = nil) {
        self.complation = complation
    }
}



extension MainContentTopMenuView {
    private func installSubviews() {

        reloadButton = NSButton.init(title: "reload", target: self, action: #selector(reloadButtonAction(sender:)))
        reloadButton.sizeToFit()
        self.addSubview(reloadButton)

        buildButton = NSButton.init(title: "build", target: self, action: #selector(buildButtonAction(sender:)))
        buildButton.sizeToFit()
        self.addSubview(buildButton)

        stopButton = NSButton.init(title: "stop", target: self, action: #selector(stopButtonAction(sender:)))
        stopButton.sizeToFit()
        self.addSubview(stopButton)

        mappingButton = NSButton.init(title: "stop", target: self, action: #selector(mappingButtonAction(sender:)))
        mappingButton.sizeToFit()
        self.addSubview(mappingButton)

        podInstallButton = NSButton.init(title: "install", target: self, action: #selector(podInstallButtonAction(sender:)))
        podInstallButton.sizeToFit()
        self.addSubview(podInstallButton)

        podUpdateButton = NSButton.init(title: "update", target: self, action: #selector(podUpdateButtonAction(sender:)))
        podUpdateButton.sizeToFit()
        self.addSubview(podUpdateButton)

        podSearchButton = NSButton.init(title: "search", target: self, action: #selector(podSearchButtonAction(sender:)))
        podSearchButton.sizeToFit()
        self.addSubview(podSearchButton)




        folderButton = NSButton.init(title: "folder", target: self, action: #selector(folderButtonAction(sender:)))
        folderButton.sizeToFit()
        self.addSubview(folderButton)

        xcodeButton = NSButton.init(title: "xcode", target: self, action: #selector(xcodeButtonAction(sender:)))
        xcodeButton.sizeToFit()
        self.addSubview(xcodeButton)

        vsCodeButton = NSButton.init(title: "vscode", target: self, action: #selector(xcodeButtonAction(sender:)))
        vsCodeButton.sizeToFit()
        self.addSubview(vsCodeButton)


        segmentControl = NSSegmentedControl.init(labels: ["左","下","右"], trackingMode: NSSegmentedControl.SwitchTracking.selectAny, target: self, action: #selector(segmentControlAction(sender:)))
        segmentControl.sizeToFit()
        self.addSubview(segmentControl)


        checkTypeButton = NSPopUpButton.init()
        checkTypeButton.addItems(withTitles: ["组件名称","是否二进制","所属业务线","负责人"])
        checkTypeButton.target = self
        checkTypeButton.action = #selector(checkTypeButtonAction)
        checkTypeButton.sizeToFit()
        self.addSubview(checkTypeButton)

        searchTextField = NSSearchField.init()
        searchTextField.placeholderString = ""
        self.addSubview(searchTextField)

        checkTypeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-5)
        }
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(checkTypeButton.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-5)
        }

        segmentControl.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }

        folderButton.snp.makeConstraints { (make) in
            make.right.equalTo(segmentControl.snp.left).offset(-30)
            make.centerY.equalTo(segmentControl)
        }
        xcodeButton.snp.makeConstraints { (make) in
            make.right.equalTo(folderButton.snp.left).offset(-5)
            make.centerY.equalTo(segmentControl)
        }
        vsCodeButton.snp.makeConstraints { (make) in
            make.right.equalTo(xcodeButton.snp.left).offset(-5)
            make.centerY.equalTo(segmentControl)
        }


        podSearchButton.snp.makeConstraints { (make) in
            make.right.equalTo(vsCodeButton.snp.left).offset(-30)
            make.centerY.equalTo(segmentControl)
        }
        podUpdateButton.snp.makeConstraints { (make) in
            make.right.equalTo(podSearchButton.snp.left).offset(-5)
            make.centerY.equalTo(segmentControl)
        }
        podInstallButton.snp.makeConstraints { (make) in
            make.right.equalTo(podUpdateButton.snp.left).offset(-5)
            make.centerY.equalTo(segmentControl)
        }



        reloadButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(segmentControl)
        }
        buildButton.snp.makeConstraints { (make) in
            make.left.equalTo(reloadButton.snp.right).offset(5)
            make.centerY.equalTo(segmentControl)
        }
        stopButton.snp.makeConstraints { (make) in
            make.left.equalTo(buildButton.snp.right).offset(5)
            make.centerY.equalTo(segmentControl)
        }

        mappingButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(segmentControl)
            make.left.equalTo(stopButton.snp.right).offset(30)
        }

    }
}
extension MainContentTopMenuView {
    @objc private func checkTypeButtonAction(sender: NSPopUpButton) {
        switch sender.indexOfSelectedItem {
        case 0:
            searchTextField.placeholderString = "当前一共有100 个组件，"
            break
        case 1:
            searchTextField.placeholderString = "请输入 是/否  or 0/1来进行搜索"
            break
        case 2:
            searchTextField.placeholderString = "请输入所属业务线名称"
            break
        case 3:
            searchTextField.placeholderString = "请输入负责人名称"
            break
        default:
            break
        }
    }

    @objc private func segmentControlAction(sender: NSSegmentedControl) {

    }
    @objc private func folderButtonAction(sender: NSButton) {
        self.complation?(sender,.floder)
    }
    @objc private func xcodeButtonAction(sender: NSButton) {
        self.complation?(sender,.xcode)
    }
    @objc private func vscodeButtonAction(sender: NSButton) {
        self.complation?(sender,.vscode)
    }


    @objc private func reloadButtonAction(sender: NSButton) {
        self.complation?(sender,.reload)
    }
    @objc private func buildButtonAction(sender: NSButton) {
        self.complation?(sender,.build)
    }
    @objc private func stopButtonAction(sender: NSButton) {
        self.complation?(sender,.stop)
    }


    @objc private func podInstallButtonAction(sender: NSButton) {
        self.complation?(sender,.pod_install)
    }
    @objc private func podUpdateButtonAction(sender: NSButton) {
        self.complation?(sender,.pod_update)
    }
    @objc private func podSearchButtonAction(sender: NSButton) {
        self.complation?(sender,.pod_searach)
    }
    @objc private func mappingButtonAction(sender: NSButton) {
        self.complation?(sender,.mapping)
    }
}
