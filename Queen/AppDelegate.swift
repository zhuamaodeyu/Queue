//
//  AppDelegate.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import LeanCloud
import LetsMove
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private var showLogin:Bool = false
    override init() {
        AppDelegate.initialSettings()

        _ = DocumentController.shared
        AppDelegate.initLeanCloud()
        super.init()
    }

}
extension AppDelegate {
    private static func initialSettings() {
        let defaults = DefaultSettings.defaults.mapKeys { $0.rawValue }
        UserDefaults.standard.register(defaults: defaults)
        NSUserDefaultsController.shared.initialValues = defaults
    }

    private static func initLeanCloud() {
        LCApplication.logLevel = .all
        do {
            try LCApplication.default.set(
                id: "8B9PpR2PlW8msf33yoGik2uO-MdYXbMMI",
                key: "fGrV7MkKgwpT7JRs0vFcVBma"
            )
        } catch {
            fatalError("\(error)")
        }
    }

    private func testLeanCloud() {
        do {
            let post = LCObject(className: "Post")
            try post.set("words", value: "Hello World!")
            _ = post.save { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
}


extension AppDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        #if DEBUG

        #else
            PFMoveToApplicationsFolderIfNecessary()
        #endif
    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        debugPrint("\(#function)")
        registerNotification()

    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
    func applicationWillBecomeActive(_ notification: Notification) {
        showWindow()
    }

//    只要Finder重新激活已在运行的应用程序，就会发送这些事件，因为有人再次双击它或使用Dock激活它。
//    默认情况下，Application Kit将通过检查是否存在任何可见的NSWindow（而不是NSPanel）对象来处理此事件，如果没有，则会通过标准的无标题文档创建（与在没有任何应用程序的情况下启动应用程序时相同）要打开的文件）。对于大多数基于文档的应用程序，将创建无标题文档。
//    应用程序委托还将有机会响应正常的无标题文档委托方法。如果在应用程序委托中实现此方法，则会在发生任何默认行为之前调用它。如果返回true，则NSApplication将正常进行。如果返回false，则NSApplication将不执行任何操作。因此，您可以使用不执行任何操作的版本实现此方法，如果您根本不希望发生任何事情，则返回false（不推荐），或者您可以实现此方法，以某种自定义方式自行处理事件，以及返回false。
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        debugPrint("\(#function)")
        if !flag {
            showWindow()
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
        welcomeWindowController.window?.makeKeyAndOrderFront(nil)
    }

    private func showLoginWindow() {
        guard let loginWindowController = NSStoryboard.windowController(name: "LoginWindowController", storyboard: "Login") as? LoginWindowController else {
            return
        }
        loginWindowController.window?.center()
        loginWindowController.window?.makeKeyAndOrderFront(nil)
    }

    private func showWindow() {
        if NSApp.orderedWindows.count > 0 || NSApp.orderedWindows.count > 0 {
            return
        }

        if let _  = LCApplication.default.currentUser {
            showWelcomeWindow()
        }else {
            if self.showLogin {
                showWelcomeWindow()
            }else {
                showLoginWindow()
            }
        }
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
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
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



