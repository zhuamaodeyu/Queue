//
//  CommandLine.swift
//  Queen
//
//  Created by 聂子 on 2019/7/20.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import Ansi

protocol CommandLineDelegate:class {
    func commandLine(commandLine:CommandLine, didUpdateOutPut content:NSAttributedString)
    func commandLineDidFinish(commandLine: CommandLine)
}
enum CommandLineStatusType {
    case none
    case runing
    case finish
    case cancel
    case prepar
}

class CommandLine {
    private(set) var running: Bool = false
    var finishSuccess: Bool {
        return self.terminationStatus == 0
    }
    private(set) var status:CommandLineStatusType = .none

    weak var delegate: CommandLineDelegate?

    private var output: NSMutableAttributedString = NSMutableAttributedString.init()

    private var process: Process?
    private var terminationStatus:Int = -1


    var uuid: String {
        return UUID.init().uuidString
    }



    init?(workSpace: String? = nil, command: String, arguments:[String],delegate: CommandLineDelegate?, qualityOfService: QualityOfService? = .default) {
        self.delegate = delegate
        self.process = Process.init()
        self.process?.qualityOfService = qualityOfService ?? .background
        self.process?.launchPath = command
        self.process?.arguments = arguments
        self.process?.environment = environment
        self.process?.currentDirectoryPath = workSpace ?? NSTemporaryDirectory()

        let outPipe = Pipe.init()
        outPipe.fileHandleForReading.waitForDataInBackgroundAndNotify(forModes: [.default,.eventTracking])
        self.process?.standardOutput = outPipe

        let errPipe = Pipe.init()
        errPipe.fileHandleForReading.waitForDataInBackgroundAndNotify(forModes: [.default,.eventTracking])
        self.process?.standardError = errPipe

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(outputNotification(notification:)),
                                               name: .NSFileHandleDataAvailable,
                                               object: outPipe.fileHandleForReading)
        NotificationCenter.default.addObserver(self, selector: #selector(outputNotification(notification:)),
                                               name: .NSFileHandleDataAvailable,
                                               object: errPipe.fileHandleForReading)
        self.status = .prepar

    }
}

extension CommandLine {
    func run() {
        self.process?.launch()
//        self.process?.waitUntilExit()
        self.running = true
        self.status = .runing

    }
    func cancel() {
        self.process?.interrupt()
        self.running = false
        self.status = .cancel

    }
}

extension CommandLine {
    @objc private func outputNotification(notification: Notification) {
        if let fileHandle = notification.object as? FileHandle {
            guard let output = String.init(data: fileHandle.availableData, encoding: .utf8) else { return  }

            let attributeString = stringToAttributeString(output: output)
            self.output.append(attributeString)
            self.delegate?.commandLine(commandLine: self, didUpdateOutPut: self.output)

            if self.process?.isRunning ?? false {
                fileHandle.waitForDataInBackgroundAndNotify(forModes: [.default,.eventTracking])
            }else {
                self.finish()
            }
        }
    }
}

extension CommandLine {

    private func stringToAttributeString(output: String) -> NSAttributedString {
        do {
           return try output.ansified()
        } catch _ {
            return NSAttributedString.init(string: output)
        }
    }


    private func finish() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSFileHandleDataAvailable, object: nil)
        self.terminationStatus = Int(self.process?.terminationStatus ?? -1)
        self.process = nil
        self.running = false
        self.status = .finish
        self.delegate?.commandLineDidFinish(commandLine: self)
    }
}


extension CommandLine:Equatable {
    static func == (lhs: CommandLine, rhs: CommandLine) -> Bool {
       return lhs.process == rhs.process
    }
}
