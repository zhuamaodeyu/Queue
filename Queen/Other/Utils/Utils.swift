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
func md5(_ string: String) -> String {
    let str = string.cString(using: String.Encoding.utf8)
    let strLen = CUnsignedInt(string.lengthOfBytes(using: String.Encoding.utf8))
    let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
    CC_MD5(str!, strLen, result)
    let hash = NSMutableString()
    for i in 0 ..< digestLen {
        hash.appendFormat("%02x", result[i])
    }
    free(result)
    return String(format: hash as String)
}
