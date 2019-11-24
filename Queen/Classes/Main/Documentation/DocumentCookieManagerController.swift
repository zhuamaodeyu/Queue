//
//  DocumentCookieManagerController.swift
//  Queen
//
//  Created by 聂子 on 2019/11/24.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class DocumentCookieManagerController: NSViewController {
    private var titleLabel: NSLabel = NSLabel.init(labelWithString: "保存密码:")
    private var scrollView: NSScrollView = NSScrollView.init(frame: .zero)
    private var tableView: NSTableView = NSTableView.init(frame: .zero)
    private var addButton: NSButton!
    private var editButton: NSButton!
    private var removeButton: NSButton!
    
}

extension DocumentCookieManagerController {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension DocumentCookieManagerController {
    private func installSubviews() {
        
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(15)
            make.top.equalTo(view).offset(10)
        }
        
        
        
        scrollView.documentView = tableView
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        addButton = NSButton.init(title: "添加", target: self, action: #selector(addButtonAction))
        addButton.sizeToFit()
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(15)
        }
        
        editButton = NSButton.init(title: "编辑", target: self, action: #selector(editButtonAction))
        editButton.sizeToFit()
        view.addSubview(editButton)
        
        editButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(addButton)
            make.left.equalTo(addButton.snp.right).offset(15)
        }
        
        removeButton = NSButton.init(title: "移除", target: self, action: #selector(removeButtonAction))
        removeButton.sizeToFit()
        view.addSubview(removeButton)
        
        removeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(addButton)
            make.left.equalTo(editButton.snp.right).offset(15)
        }
        
    }
}


extension DocumentCookieManagerController {
    @objc private func addButtonAction() {
        
    }
    @objc private func editButtonAction() {
        
    }
    @objc private func removeButtonAction() {
        
    }
}
