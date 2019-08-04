//
//  Path.swift
//  Queen
//
//  Created by 聂子 on 2019/8/4.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

class Path {
    static var ruby: String {
        guard let path = Bundle.main.path(forResource: "ruby", ofType: nil, inDirectory: "bundle/bin") else {
            return ""
        }
        return path
    }
    static var pod:String {
        guard let path = Bundle.main.path(forResource: "pod", ofType: nil, inDirectory: "bundle/bin") else {
            return ""
        }
        return path
    }
    static var git: String {
        guard let path = Bundle.main.path(forResource: "git", ofType: nil, inDirectory: "bundle/bin") else {
            return ""
        }
        return path
    }
    static var xcodeproj: String {
        guard let path = Bundle.main.path(forResource: "xcodeproj", ofType: nil, inDirectory: "bundle/bin") else {
            return ""
        }
        return path
    }
    static var gem: String {
        guard let path = Bundle.main.path(forResource: "gem", ofType: nil, inDirectory: "bundle/bin") else {
            return ""
        }
        return path
    }


    static var analyzerScript: String {
        guard let path = Bundle.main.path(forResource: "CocoaPods_analyzer", ofType: "rb", inDirectory: "bundle/script") else {
            return ""
        }
        return path
    }
    static var basicScript: String {
        guard let path = Bundle.main.path(forResource: "CocoaPods_basic", ofType: "rb", inDirectory: "bundle/script") else {
            return ""
        }
        return path
    }
    static var podfileScript: String {
        guard let path = Bundle.main.path(forResource: "CocoaPods_podfile", ofType: "rb", inDirectory: "bundle/script") else {
            return ""
        }
        return path
    }
    static var searchScript: String {
        guard let path = Bundle.main.path(forResource: "CocoaPods_search", ofType: "rb", inDirectory: "bundle/script") else {
            return ""
        }
        return path
    }

    static var resetEnvironment: String {
        guard let path = Bundle.main.path(forResource: "resetEnvironment", ofType: nil, inDirectory: "bundle/script") else {
            return ""
        }
        return path
    }
    static var cacheEnvironment: String {
        guard let path = Bundle.main.path(forResource: "cacheEnvironment", ofType: nil, inDirectory: "bundle/script") else {
            return ""
        }
        return path
    }


    static var environment: String {
        guard let path = Bundle.main.path(forResource: "bundle-env", ofType: nil, inDirectory: "bundle/bin") else {
            return ""
        }
        return path
    }
}
