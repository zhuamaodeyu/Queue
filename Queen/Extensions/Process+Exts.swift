//
//  Process+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa



extension Process {
    /// 打开APP
    ///
    /// - Parameter path: 可执行文件路径
    /// 不是这个路径， 在 包目录下
    ///    [[NSWorkspace sharedWorkspace] fullPathForApplication:@"Pages"];
    public static func openAppWith(exec path: String) {
        let process = Process.init()
        process.launchPath = path
        process.launch()
    }

    /// app 多开
    ///
    /// - Parameter args: args  main 函数中可以获得参数
    public static func moreAction(args:[String] = []) {
        let path = Bundle.main.executablePath
        let process = Process.init()
        process.launchPath = path
        process.arguments = args
        process.launch()
    }


    /// run command
    ///
    /// - Parameters:
    ///   - path: path description
    ///   - args: args description
    /// - Returns: return value description success string or "" , false nil
    public static func run(command path :String, args: [String] = []) -> String? {
        let process = Process.init()
        process.launchPath = path
        process.arguments = args
        let pipe = Pipe.init()
        process.standardOutput = pipe

        process.launch()
        process.waitUntilExit()

        if process.terminationStatus == 0 {
            return String.init(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? ""
        }
        return nil
    }

    /// 执行 命令
    ///
    /// - Parameters:
    ///   - path: path
    ///   - args: 参数
    ///   - complation: 执行结果回调
    public static func run(command path :String, args: [String] = [], environment:[String:String] = [:],complation:((_ process: Process,_ output: String?, _ error:String?)-> Void)? = nil) {

        let process = Process.init()
        process.launchPath = path
        process.arguments = args

        for (key,value) in environment {
            process.environment?.updateValue(value, forKey: key)
        }
        let pipe = Pipe.init()
        process.standardOutput = pipe

        let errPipe = Pipe.init()
        process.standardError = errPipe

        process.launch()
        process.waitUntilExit()

        complation?(process,
                    String.init(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8),
                    String.init(data: errPipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8))

    }
}


//public static func runRoot(command path: String, arg:[String] = [], complation:((_ output: String?, _ error:String?)-> Void)? = nil) {
//    let process = STPrivilegedTask.init()
//    process.setCurrentDirectoryPath(Bundle.main.resourcePath)
//    process.setLaunchPath(path)
//    process.setArguments(arg)
//
//    let err = process.launch()
//    process.waitUntilExit()
//
//    switch err {
//    case errAuthorizationSuccess:
//        complation?(String.init(bytes: process.outputFileHandle()?.readDataToEndOfFile() ?? Data.init(), encoding: .utf8), nil)
//    default:
//        complation?(nil, String.init(bytes: process.outputFileHandle()?.readDataToEndOfFile() ?? Data.init(), encoding: .utf8))
//    }
//}

// [NSTask not picking up $PATH from the user's environment](https://stackoverflow.com/questions/386783/nstask-not-picking-up-path-from-the-users-environment)
// [NSTask launch path not accessible. Works in Xcode. Error shown out of XCode](https://stackoverflow.com/questions/17340569/nstask-launch-path-not-accessible-works-in-xcode-error-shown-out-of-xcode)
// [Find out location of an executable file in Cocoa](https://stackoverflow.com/questions/208897/find-out-location-of-an-executable-file-in-cocoa)
//        NSDictionary *environmentDict = [[NSProcessInfo processInfo] environment];
//        NSString *shellString = [environmentDict objectForKey:@"SHELL"];
//        [task setLaunchPath:@"/bin/bash"];
//        NSArray *args = [NSArray arrayWithObjects:@"-l",
//            @"-c",
//             @"which git", //Assuming git is the launch path you want to run
//            nil];
//        [task setArguments: args];



//        STPrivilegedTask
//        var errDic: NSDictionary?
//        let argsString = arg.joined(separator: " ")
//        let script = "do shell script \"\(path) \(argsString)\" with administrator privileges"
//        let appScript = NSAppleScript.init(source: script)
//        let eventResult = appScript?.executeAndReturnError(&errDic)
//        if eventResult?.booleanValue ?? false {
//
//            var errorMessage:String? = nil
//
//            if let errorCode = errDic?.value(forKey: NSAppleScript.errorNumber) as? NSNumber, errorCode.intValue == -128 {
//                errorMessage = "The administrator password is required to do this."
//            }
//
//            if errorMessage?.isEmpty ?? true {
//                 errorMessage = errDic?.value(forKey: NSAppleScript.errorMessage) as? String
//            }
//            complation?(nil, errorMessage)
//        }else {
//            complation?(eventResult?.stringValue, nil)
//        }

