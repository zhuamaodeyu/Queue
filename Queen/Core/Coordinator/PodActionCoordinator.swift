//
//  PodActionCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

enum PodActionType {
    case `init`(options: PodActionOptions)
    case update(options: PodActionOptions)
    case install(options: PodActionOptions)
}

struct PodActionOptions {
    let verbose: Bool

    var commandOptions : [String] {
        var opts = [String]()
        if verbose { opts.append("--verbose") }
        return opts
    }
}
class PodActionCoordinator: NSObject {
    private var successBlock:((_ success:Bool) -> Void)?
    private var logBlock:((_ log: NSAttributedString) -> Void)?
    private var commandLine: CommandLine?
}
extension PodActionCoordinator {
    func action(type: PodActionType,logBlock:((_ log: NSAttributedString) -> Void)?, successBlock:((_ success:Bool) -> Void)?) {
        if let _ = commandLine {
            return
        }
        self.successBlock = successBlock
        self.logBlock = logBlock
        self.commandLine = CommandLine.init(workSpace: "", command: "pod", arguments: [], delegate: self, qualityOfService: .default)
        self.commandLine?.run()
    }
}

extension PodActionCoordinator: CommandLineDelegate {
    func commandLine(commandLine: CommandLine, didUpdateOutPut content: NSAttributedString) {
        self.logBlock?(content)
    }

    func commandLineDidFinish(commandLine: CommandLine) {
        self.successBlock?(commandLine.finishSuccess)
        self.commandLine = nil
    }
}
