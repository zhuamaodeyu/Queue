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


    var yamlData: Data?
    var configData: Data?
    var mapping: Data?

    override init() {
        self.writeEncoding = .utf8
        self.readEncoding = .utf8
        self.autosaveIdentifier = String(UUID.init().uuidString.prefix(uniqueFileIDLength))
        super.init()
        self.hasUndoManager = true

        self.updateChangeCount(.changeRedone)
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
        super.autosave(withImplicitCancellability: autosavingIsImplicitlyCancellable) { (error) in
            defer {
                completionHandler(nil)
            }
            guard  error == nil else {return}
        }
    }
}

extension Document {

    //返回根目录
    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        rootWrapper.filename = typeName
        rootWrapper.preferredFilename = typeName
        let yamlWrapper = FileWrapper.init(regularFileWithContents: "测试".data(using: .utf8)!)
        yamlWrapper.filename = DocumentAssociatedKeys.yaml
        yamlWrapper.preferredFilename = DocumentAssociatedKeys.yaml
        rootWrapper.addFileWrapper(yamlWrapper)

        let configWrapper = FileWrapper.init(regularFileWithContents: "config".data(using: .utf8)!)
        configWrapper.filename = DocumentAssociatedKeys.config
        configWrapper.preferredFilename = DocumentAssociatedKeys.config
        rootWrapper.addFileWrapper(configWrapper)
        return self.rootWrapper
    }

    //读取时调用~ 包中的数据可以通过 filleWraper获取
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        // 1. 获取所有子的
        if let wrappers = fileWrapper.fileWrappers {
            if let yamlWrapper = wrappers[DocumentAssociatedKeys.yaml], let configWrapper = wrappers[DocumentAssociatedKeys.config] {
                self.yamlData = yamlWrapper.regularFileContents
                self.configData = configWrapper.regularFileContents
            }
        }
        self.rootWrapper = fileWrapper
    }
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


    override func save(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType, completionHandler: @escaping (Error?) -> Void) {
        super.save(to: url, ofType: typeName, for: saveOperation) { [weak self](error) in
            defer {
                completionHandler(error)
            }
            //更改状态
            guard error == nil else {
                self?.updateChangeCount(.changeAutosaved)
                return}
        }
    }
    override func writeSafely(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) throws {
       try super.writeSafely(to: url, ofType: typeName, for: saveOperation)
    }
}
