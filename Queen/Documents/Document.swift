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


private let uniqueFileIDLength = 13

class Document: NSDocument {

    private var rootWrapper: FileWrapper = FileWrapper.init(directoryWithFileWrappers: [:])

    private(set) var writeEncoding:String.Encoding
    private(set) var readEncoding:String.Encoding
    private var autosaveIdentifier: String
    private var lastSaveData: Data?




    override init() {
        self.writeEncoding = .utf8
        self.readEncoding = .utf8
        self.autosaveIdentifier = String(UUID.init().uuidString.prefix(uniqueFileIDLength))
        super.init()
        self.hasUndoManager = true

    }

    override func makeWindowControllers() {
        guard let windowController = NSStoryboard.windowController(name: "MainWindowController", storyboard: "MainUI", bundle: nil) else {
            return
        }
        self.addWindowController(windowController)
    }
}


extension Document {
    override class var autosavesInPlace: Bool {
        return true
    }
    override class func canConcurrentlyReadDocuments(ofType: String) -> Bool {

        return true
    }

    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
        return true
    }

    override func autosave(withImplicitCancellability autosavingIsImplicitlyCancellable: Bool, completionHandler: @escaping (Error?) -> Void) {
        //自动保存
        completionHandler(NSError.init(domain: "错误提示", code: 0, userInfo: nil))
    }

}

extension Document {

    //返回根目录
    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        //        1. 创建目录文件包装器。
        //        2. 将您应用的数据导入Data对象。
        // 2.1 子文件夹
        let subDirectory = FileWrapper.init(directoryWithFileWrappers: [:])
        subDirectory.filename = "xxxxx"
        let data = "".data(using: .utf8)
        //        3. 创建文件包装器并将该文件添加到目录文件包装器中。
        let wrapper = FileWrapper.init(regularFileWithContents: data!)
        subDirectory.addFileWrapper(wrapper)
        rootWrapper.addFileWrapper(subDirectory)
        return self.rootWrapper
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



// MARK: - save extension
extension Document {

    override func prepareSavePanel(_ savePanel: NSSavePanel) -> Bool {
        savePanel.isExtensionHidden = false
        savePanel.canSelectHiddenExtension = false

        if let fileType = self.fileType,
            let pathExtension = self.fileNameExtension(forType: fileType, saveOperation: .saveOperation) {

            savePanel.allowedFileTypes = [pathExtension]
        }

        return super.prepareSavePanel(savePanel)
    }

    override func fileNameExtension(forType typeName: String, saveOperation: NSDocument.SaveOperationType) -> String? {
        return DocumentType.default.extensions.first
    }
}
