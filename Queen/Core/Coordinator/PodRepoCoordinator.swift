//
//  PodRepoCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/7/31.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class PodRepoCoordinator: NSObject {
    private var successBlock:((_ success:Bool) -> Void)?
    private var logBlock:((_ log: NSAttributedString) -> Void)?
    private var updateLogBlock:((_ log: NSAttributedString) -> Void)?
    private var updateSuccessBlock:((_ success:Bool) -> Void)?
    private var addSourcesCommandLine:CommandLine?
    private var updateCommandLine: CommandLine?
}


extension PodRepoCoordinator {

    func update(logComplation:((_ log: NSAttributedString) -> Void)? = nil,complation:@escaping ((_ success:Bool)->Void)) {
        self.updateLogBlock = logComplation
        self.updateSuccessBlock = complation
        self.updateCommandLine = CommandLine.init(command: Path.pod, arguments: ["repo","update","--verbose"], delegate: self, qualityOfService: .userInitiated)
        self.updateCommandLine?.run()
    }

    func add(sources:[SpecSourceEntity], logComplation:((_ log: NSAttributedString) -> Void)? = nil,complation:@escaping ((_ success:Bool)->Void)) {
        self.successBlock = complation
        self.logBlock = logComplation

        var args = [String]()
        args.append(contentsOf: ["repo","add"])
        for (index, item) in sources.enumerated() {
            args.append(item.name?.stringValue ?? "")
            args.append(item.host?.stringValue ?? "")
            if index != sources.count - 1 {
                args.append(contentsOf: ["&&",Path.pod,"repo","add"])
            }
        }

        self.addSourcesCommandLine = CommandLine.init(workSpace: NSHomeDirectory(), command: Path.pod, arguments: args, delegate: self, qualityOfService: .userInitiated)
        addSourcesCommandLine?.run()
    }
}


extension PodRepoCoordinator {
    private func checkUpdate() -> Bool {
        return false
    }
}

extension PodRepoCoordinator : CommandLineDelegate {
    func commandLine(commandLine: CommandLine, didUpdateOutPut content: NSAttributedString) {
        if commandLine == addSourcesCommandLine {
            self.logBlock?(content)
        }
        if commandLine == updateCommandLine {
            self.updateLogBlock?(content)
        }
    }

    func commandLineDidFinish(commandLine: CommandLine) {
        if commandLine == addSourcesCommandLine {
            self.successBlock?(commandLine.finishSuccess)
        }
        if commandLine == updateCommandLine {
            self.updateSuccessBlock?(commandLine.finishSuccess)
        }
    }


}
