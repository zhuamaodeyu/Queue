//
//  AppDelegate+Menu.swift
//  Queen
//
//  Created by 聂子 on 2019/11/23.
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

}

// MARK: Menu Application
extension AppDelegate {
    // 关于
    @IBAction func aboutApplication(_ sender: Any?) {
        
    }
    //
    @IBAction func preferences(_ sender: Any?) {
        
    }
}

// MARK: Menu file
extension AppDelegate {
    
}
// MARK:
extension AppDelegate {
    
}
