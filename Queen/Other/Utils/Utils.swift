//
//  Utils.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

import CommonCrypto

//+ (NSString *)computerName {
//    return [(id)SCDynamicStoreCopyComputerName(NULL, NULL) autorelease];
//}
func md5(_ string: String) -> String? {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    var digest = [UInt8](repeating: 0, count: length)

    if let d = string.data(using: String.Encoding.utf8) {
        _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
            CC_MD5(body, CC_LONG(d.count), &digest)
        }
    }

    return (0..<length).reduce("") {
        $0 + String(format: "%02x", digest[$1])
    }
}
