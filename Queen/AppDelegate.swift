//
//  AppDelegate.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    override init() {
        AppDelegate.initialSettings()

        _ = DocumentController.shared
        super.init()
    }

}
extension AppDelegate {
    private static func initialSettings() {
        let defaults = DefaultSettings.defaults.mapKeys { $0.rawValue }
        UserDefaults.standard.register(defaults: defaults)
        NSUserDefaultsController.shared.initialValues = defaults
    }
}


extension AppDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        registerNotification()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
    func applicationWillBecomeActive(_ notification: Notification) {
        if NSApp.orderedDocuments.count == 0 {
            showWelcomeWindow()
        }
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            showWelcomeWindow()
        }
        return true
    }

}

extension AppDelegate {
    private func showWelcomeWindow() {
        guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Main") as? WelcomeWindowController else {
            return
        }
        welcomeWindowController.window?.center()
        welcomeWindowController.showWindow(nil)
    }
}



// MARK: - NSUserNotificationCenterDelegate
extension AppDelegate : NSUserNotificationCenterDelegate {

    private func registerNotification() {
        NSUserNotificationCenter.default.delegate = self
    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {

    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {

    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}

extension AppDelegate {
    // 系统调用此方法
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        let dispatchGroup = DispatchGroup.init()

        for filename in filenames {
            guard self.application(sender, openFile: filename) else {
                continue
            }
            let url = URL.init(fileURLWithPath: filename)
            dispatchGroup.enter()
            DocumentController.shared.openDocument(withContentsOf: url, display: true) { (document, documentWasAlreadyOpen, error) in
                defer {
                    dispatchGroup.leave()
                }
                if let error = error {
                    NSApp.presentError(error)

                    let cancelled = (error as? CocoaError)?.code == .userCancelled
                    NSApp.reply(toOpenOrPrint: cancelled ? .cancel : .failure)
                }
            }
            dispatchGroup.notify(queue: .main) {

            }
        }
    }
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        // 判断是否支持当前的文件格式
        let url = URL.init(fileURLWithPath: filename)
        guard DocumentType.default.extensions.contains(url.pathExtension)  else {
            return false
        }
        return true
    }
    func applicationOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return false
    }

}


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



