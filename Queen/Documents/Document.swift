//
//  Document.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

//https://juejin.im/post/5a45b2e65188257d7242be62
//https://www.meandmark.com/blog/2017/08/creating-a-document-based-mac-application-using-swift-and-storyboards/
// https://stackoverflow.com/questions/12130632/using-nsfilewrapper-in-nsdocument-made-of-various-files
class Document: NSDocument {

    private var rootWrapper: FileWrapper?

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


     //返回根目录
    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
//        1. 创建目录文件包装器。
       if self.rootWrapper == nil {
            self.rootWrapper = FileWrapper.init(directoryWithFileWrappers: [:])
        }

//        2. 将您应用的数据导入Data对象。
            // 2.1 子文件夹
        let subDirectory = FileWrapper.init(directoryWithFileWrappers: [:])
        subDirectory.filename = "xxxxx"
        let data = "".data(using: .utf8)
//        3. 创建文件包装器并将该文件添加到目录文件包装器中。
        let wrapper = FileWrapper.init(regularFileWithContents: data!)
        subDirectory.addFileWrapper(wrapper)
        rootWrapper?.addFileWrapper(subDirectory)
        return self.rootWrapper!
    }

    //读取时调用~ 包中的数据可以通过 filleWraper获取
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        // 1. 获取所有子的
        if let wrappers = fileWrapper.fileWrappers {
            let subDir = wrappers["xxxxx"]
            if let files = subDir?.fileWrappers,let _ = files["xxx.html"] {
                // 2. 读取数据
            }
        }
    }
//    [self updateChangeCount:NSChangeDone];
}


