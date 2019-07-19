//
//  LoginViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/19.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    private var accountField: NSTextField!
    private var passwordField: NSTextField!
    private var iconImageView: IconImageView!

    var subWindow: NSWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        iconImageView = IconImageView.init()
        self.view.addSubview(iconImageView)

        accountField = NSTextField.init()
        accountField.placeholderString = ""
        accountField.isBordered = true
        self.view.addSubview(accountField)

        accountField = NSTextField.init()
        accountField.placeholderString = ""
        accountField.isBordered = true
        self.view.addSubview(accountField)
    }

}


extension LoginViewController {

    @objc private func login(sender: NSButton) {
        guard !accountField.stringValue.isEmpty && !passwordField.stringValue.isEmpty else {
            return
        }


    }
}
