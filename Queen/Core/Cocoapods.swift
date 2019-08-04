//
//  Cocoapods.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import ObjectMapper

struct SpecSourceModel:Mappable {
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        host    <- map["host"]
        name    <- map["name"]
    }

    var host: String = ""
    var name: String = ""

}

class Cocoapods {
    static let instance = Cocoapods.init()
    private(set) var sources:[SpecSourceModel] = []

    private init() {
        getSources()
    }
}

extension Cocoapods {
    /// 检测路径是否是一个 cocoapod 项目
    ///
    /// - Parameter path: path
    /// - Returns: default false
    static func check(url path: String) -> Bool {
        
        return false
    }
}

extension Cocoapods {
    private func getSources() {
        if Path.ruby.isEmpty || Path.basicScript.isEmpty {
            debugPrint("ruby command path is empty or basic script path is empty")
            return
        }
        Process.syncRun(command: Path.ruby, args: [Path.basicScript ,"sources"]) { (process, output, error) in
            // TODO: json string -----> object
            if !(error?.isEmpty ?? false) {
                debugPrint("\(String(describing: error))")
                return
            }

            if output?.isEmpty ?? true {
                debugPrint("output is empty, please check command")
                return
            }
            self.sources = Mapper<SpecSourceModel>().mapArray(JSONString: output ?? "") ?? []
        }
    }
}
