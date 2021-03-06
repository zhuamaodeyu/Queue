//
//  CommandLine.swift
//  Queen
//
//  Created by 聂子 on 2019/7/20.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

protocol CommandLineDelegate:class {
    func commandLine(commandLine:CommandLine, didUpdateOutPut content:NSAttributedString)
    func commandLineDidFinish(commandLine: CommandLine)
}

class CommandLine {
    private let environment = ["HOME": NSHomeDirectory(),
                               "LANG": "en_GB.UTF-8",
                               "TERM": "xterm-256color"]

    private(set) var running: Bool = false
    var finishSuccess: Bool {
        return self.terminationStatus == 0
    }

    weak var delegate: CommandLineDelegate?

    private var output: NSMutableAttributedString = NSMutableAttributedString.init()

    private var process: Process?
    private var terminationStatus:Int = -1




    init?(workSpace: String, command: String, arguments:[String],delegate: CommandLineDelegate?, qualityOfService: QualityOfService?) {
        let envBundleScript = Bundle.main.path(forResource: "bundle-env", ofType: nil, inDirectory: "bundle/bin")
        guard let bundle = envBundleScript else {
            return nil
        }

        self.process = Process.init()
        self.process?.qualityOfService = qualityOfService ?? .background
        self.process?.launchPath = "/bin/sh \(bundle) \(command)"
        self.process?.arguments = arguments
        self.process?.environment = self.environment
        self.process?.currentDirectoryPath = workSpace

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
    }
}

extension CommandLine {
    func run() {
        self.process?.launch()
        self.running = true
    }
    func cancel() {
        self.process?.interrupt()
        self.running = false
    }
}

extension CommandLine {
    @objc private func outputNotification(notification: Notification) {
        if let fileHandle = notification.object as? FileHandle{
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
        return NSAttributedString.init(string: "")
    }


    private func finish() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSFileHandleDataAvailable, object: nil)
        self.terminationStatus = Int(self.process?.terminationStatus ?? -1)
        self.process = nil
        self.running = false
        self.delegate?.commandLineDidFinish(commandLine: self)
    }
}
