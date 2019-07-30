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
    private var progressView:NSProgressIndicator!

    private var accountLineView:NSView = NSView.init()
    private var passwordLineView: NSView = NSView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        accountField.stringValue = "playtomandjerry@gmail.com"
        passwordField.stringValue = "Xiaohundan3575"
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

        progressView = NSProgressIndicator.init()
        progressView.style = .spinning
        progressView.controlSize = .mini
        progressView.isHidden = true
        progressView.sizeToFit()
        self.view.addSubview(progressView)

        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(10)
            make.size.equalTo(CGSize.init(width: 15, height: 15))
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

        progressView.snp.makeConstraints { (make) in
            make.center.equalTo(loginButton)
            make.size.equalTo(loginButton)
        }

    }

}


extension LoginViewController {

    @objc private func close() {
        self.view.window?.close()
    }


    @objc private func login(sender: NSButton) {
        guard !accountField.stringValue.isEmpty && !passwordField.stringValue.isEmpty else {
            return
        }
        self.progressView.startAnimation(nil)
        login { [weak self] (result) in
            self?.progressView.stopAnimation(nil)
            switch result {
            case .success(object: _):
                guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Main") as? WelcomeWindowController else {
                    return
                }
                welcomeWindowController.window?.center()
                welcomeWindowController.showWindow(nil)
                self?.view.window?.close()
            case .failure(error: _):
                break
            }
        }
    }
}


extension LoginViewController {
    private func login(compation: @escaping (LCValueResult<LCUser>) -> Void) {
        if test(input: accountField.stringValue, pattern: email_regex) {
                let _ = LCUser.logIn(email: accountField.stringValue, password: passwordField.stringValue) { result in
                   compation(result)
                }
            }
        if test(input: accountField.stringValue, pattern: "") {
                let _ = LCUser.logIn(mobilePhoneNumber: accountField.stringValue, password: passwordField.stringValue) { result in
                    compation(result)
                }
            }else {
                let _ = LCUser.logIn(username: accountField.stringValue, password: passwordField.stringValue) { result in
                        compation(result)
            }
        }
    }
}
