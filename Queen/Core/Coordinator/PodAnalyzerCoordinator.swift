//
//  PodAnalyzerCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/7/31.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


struct PodAnalyzerModel {

}

class PodAnalyzerCoordinator: NSObject {
    private var successBlock:((_ models:[PodAnalyzerModel]) -> Void)?
    private var logBlock:((_ log: NSAttributedString) -> Void)?
    private var commandLine:CommandLine?
    
}

extension PodAnalyzerCoordinator {
    func analyzer(podfile path:URL,logComplation:((_ log: NSAttributedString) -> Void)? = nil,complation:@escaping ((_  models:[PodAnalyzerModel])->Void)) {
        self.logBlock = logComplation
        self.successBlock = complation
        self.commandLine = CommandLine.init(workSpace: path.absoluteString, command: Path.analyzerScript, arguments: [path.path], delegate: self, qualityOfService: .background)
        self.commandLine?.run()
    }
}
extension PodAnalyzerCoordinator : CommandLineDelegate {
    func commandLine(commandLine: CommandLine, didUpdateOutPut content: NSAttributedString) {
        self.logBlock?(content)
    }

    func commandLineDidFinish(commandLine: CommandLine) {
        self.successBlock?([])
    }

    
}
