//
//  PodSearchCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/7/31.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

struct PodSearchModel {

}

class PodSearchCoordinator: NSObject {
    private var successBlock:((_ models:PodSearchModel) -> Void)?
    private var logBlock:((_ log: NSAttributedString) -> Void)?
    private var commandLine:CommandLine?

    override init() {
        super.init()
    }

    func search(key:String, logComplation:((_ log: NSAttributedString) -> Void)? = nil,complation:@escaping ((_ models:PodSearchModel)->Void)) {
        self.successBlock = complation
        self.logBlock = logComplation
        self.commandLine = CommandLine.init(command: "pod", arguments: [key], delegate: self, qualityOfService: .userInitiated)
        self.commandLine?.run()

    }
}

extension PodSearchCoordinator : CommandLineDelegate {
    func commandLine(commandLine: CommandLine, didUpdateOutPut content: NSAttributedString) {

    }

    func commandLineDidFinish(commandLine: CommandLine) {
        
    }


}
