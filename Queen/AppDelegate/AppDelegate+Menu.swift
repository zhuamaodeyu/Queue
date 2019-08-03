//
//  AppDelegate+Menu.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


// MARK: - menu action
extension AppDelegate {
    /// activate self and perform "New" menu action
    @IBAction func newDocumentActivatingApplication(_ sender: Any?) {

        NSApp.activate(ignoringOtherApps: true)
        NSDocumentController.shared.newDocument(sender)
    }


    /// activate self and perform "Open..." menu action
    @IBAction func openDocumentActivatingApplication(_ sender: Any?) {

        NSApp.activate(ignoringOtherApps: true)
        NSDocumentController.shared.openDocument(sender)
    }
    /// show preferences window
    @IBAction func showPreferences(_ sender: Any?) {


    }
    /// open bug report page in default web browser
    @IBAction func reportBug(_ sender: Any?) {


    }
}



