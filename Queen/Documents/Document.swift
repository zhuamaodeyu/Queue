//
//  Document.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

//https://juejin.im/post/5a45b2e65188257d7242be62
class Document: NSDocument {


    override init() {
        super.init()

    }
    //是否自动保存(出用户选择外的所有保存方式 都是非自动保存,像按钮..点击的方法中可以保存,其他的不能)
    override class var autosavesInPlace: Bool {
        return true
    }

    //用于为Document绑定WindowController,当打开新的Document时,对应的WindowController就会被打开~(不绑定也是可以的)
    override func makeWindowControllers() {
        guard let windowController = NSStoryboard.windowController(name: "MainWindowController", storyboard: "MainUI", bundle: nil) else {
            return
        }
        self.addWindowController(windowController)
    }

    //自动保存时调用的方法~ 当前是否能判断是否
    override func autosave(withImplicitCancellability autosavingIsImplicitlyCancellable: Bool, completionHandler: @escaping (Error?) -> Void) {

        completionHandler(NSError.init(domain: "错误提示", code: 0, userInfo: nil))
    }


     //保存时调用
    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        let  fileWrappers  = FileWrapper(directoryWithFileWrappers: [:])

        return fileWrappers
    }

    //读取时调用~ 包中的数据可以通过 filleWraper获取
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        for item in fileWrapper.fileWrappers! {
            Swift.print("获得\(item.key)")
        }
    }
}



////将当前文档保存时调用
//override func data(ofType typeName: String) throws -> Data {
//    //在此处插入代码，将文档写入指定类型的数据，如果失败则抛出错误。
//    //或者，您可以删除此方法并覆盖fileWrapper（ofType :)，write（to：ofType :)或write（to：ofType：for：originalContentsURL :)。
//    throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//}
////当读取新的数据时调用
//override func read(from data: Data, ofType typeName: String) throws {
//    // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
//    // Alternatively, you could remove this method and override read(from:ofType:) instead.
//    // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
//    throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//}
