//
//  LoginViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/19.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import LeanCloud
class LoginViewController: NSViewController {

    private var accountField: NSTextField!
    private var passwordField: NSSecureTextField!
    private var iconImageView: IconImageView!
    private var loginButton:NSButton!
    private var closeButton: NSButton!

    private var accountLineView:NSView = NSView.init()
    private var passwordLineView: NSView = NSView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        if accountField.stringValue.isEmpty {
            accountField.becomeFirstResponder()
        }else {
            passwordField.becomeFirstResponder()
        }
    }
}


extension LoginViewController {
    private func installSubviews() {
        closeButton = NSButton.init(image: NSImage.init(named: NSImage.Name.init("close_icon"))!, target: self, action: #selector(close))
        closeButton.isBordered = false
        closeButton.bezelStyle = .smallSquare
        closeButton.imagePosition = .imageOnly
        closeButton.focusRingType = .none
        closeButton.setButtonType(.momentaryPushIn)
        self.view.addSubview(closeButton)



        iconImageView = IconImageView.init()
        iconImageView.image = NSImage.init(named: NSImage.Name.init("personalImg"))
        self.view.addSubview(iconImageView)

        //无边框window 默认不能成为主窗口
        accountField = NSTextField.init()
        accountField.placeholderString = "请输入用户名"
        accountField.font = NSFont.systemFont(ofSize: 13)
        accountField.isBordered = false
        accountField.drawsBackground = false
        accountField.alignment = .left
        accountField.focusRingType = .none
        self.view.addSubview(accountField)

        passwordField = NSSecureTextField.init()
        passwordField.placeholderString = "请输入密码"
        passwordField.isEditable = true
        passwordField.isBordered = false
        passwordField.drawsBackground = false
        passwordField.alignment = .left
        // 选中高亮
        passwordField.focusRingType = .none
        passwordField.font = NSFont.systemFont(ofSize: 13)
        self.view.addSubview(passwordField)

        accountLineView.backgroundColor = NSColor.init(white: 0, alpha: 0.4)
        passwordLineView.backgroundColor = NSColor.init(white: 0, alpha: 0.4)
        self.view.addSubview(accountLineView)
        self.view.addSubview(passwordLineView)

        loginButton = NSButton.init(image: NSImage.init(named: NSImage.Name.init("loginBtn"))!, target: self, action: #selector(login(sender:)))
        loginButton.setButtonType(.momentaryPushIn)
        loginButton.bezelStyle = .smallSquare
        loginButton.sizeToFit()
        loginButton.isBordered = false
        self.view.addSubview(loginButton)

        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(10)
            make.size.equalTo(CGSize.init(width: 10, height: 10))
        }

        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 100))
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(50)
        }
        accountField.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.top.equalTo(iconImageView.snp.bottom).offset(30)
            make.height.equalTo(25)
        }
        accountLineView.snp.makeConstraints { (make) in
            make.width.equalTo(accountField)
            make.top.equalTo(accountField.snp.bottom)
            make.height.equalTo(1)
            make.centerX.equalTo(accountField)
        }
        passwordField.snp.makeConstraints { (make) in
            make.left.equalTo(accountField)
            make.top.equalTo(accountLineView.snp.bottom).offset(10)
            make.right.equalTo(loginButton.snp.left).offset(5)
            make.height.equalTo(25)
        }
        passwordLineView.snp.makeConstraints { (make) in
            make.width.equalTo(accountField)
            make.top.equalTo(passwordField.snp.bottom)
            make.height.equalTo(1)
            make.centerX.equalTo(accountLineView)
        }
        loginButton.snp.makeConstraints { (make) in
            make.right.equalTo(accountField)
            make.centerY.equalTo(passwordField)
            make.height.equalTo(passwordField)
            make.width.equalTo(loginButton.snp.height)
        }
    }

}


extension LoginViewController {

    @objc private func close() {
        guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Main") as? WelcomeWindowController else {
            return
        }
        welcomeWindowController.window?.center()
        welcomeWindowController.showWindow(nil)
        self.view.window?.close()
    }


    @objc private func login(sender: NSButton) {
        guard !accountField.stringValue.isEmpty && !passwordField.stringValue.isEmpty else {
            return
        }
        guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Main") as? WelcomeWindowController else {
            return
        }
        welcomeWindowController.window?.center()
        welcomeWindowController.showWindow(nil)
        self.view.window?.close()

        return

        let _ = LCUser.logIn(username: accountField.stringValue , password: passwordField.stringValue) { result in
            switch result {
            case .success(object: _):
                guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Main") as? WelcomeWindowController else {
                    return
                }
                welcomeWindowController.window?.center()
                welcomeWindowController.showWindow(nil)
            case .failure(error: _):
                break
            }
        }

    }
}
