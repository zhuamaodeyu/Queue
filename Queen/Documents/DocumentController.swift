//
//  DocumentController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/16.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class DocumentController: NSDocumentController {
    private(set) lazy var autosaveDirectoryURL: URL =  try! FileManager.default.url(for: .autosavedInformationDirectory,
                                                                                    in: .userDomainMask,
                                                                                    appropriateFor: nil,
                                                                                    create: true)
    override init() {
        super.init()
        //        self.autosavingDelay = UserDefaults.standard[.autosavingDelay]
        self.autosavingDelay = 10
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    // 自动插入share 菜单
    override var allowsAutomaticShareMenu: Bool {

        return false
    }

    override func openDocument(withContentsOf url: URL, display displayDocument: Bool, completionHandler: @escaping (NSDocument?, Bool, Error?) -> Void) {
        super.openDocument(withContentsOf: url, display: displayDocument) {  (document, documentWasAlreadyOpen, error) in

            completionHandler(document, documentWasAlreadyOpen, error)
        }
    }

    override func makeDocument(for urlOrNil: URL?, withContentsOf contentsURL: URL, ofType typeName: String) throws -> NSDocument {
        let document = try super.makeDocument(for: urlOrNil, withContentsOf: contentsURL, ofType: typeName)
        return document
    }
}
