//
//  Regex.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation


//只能为中文
public func onlyInputChineseCharacters(_ string: String) -> Bool {
    let inputString = "[\u{4e00}-\u{9fa5}]+"
    let predicate = NSPredicate(format: "SELF MATCHES %@", inputString)
    let Chinese = predicate.evaluate(with: string)
    return Chinese

}
//只能为数字
public func onlyInputTheNumber(_ string: String) -> Bool {
    let numString = "[0-9]*"
    let predicate = NSPredicate(format: "SELF MATCHES %@", numString)
    let number = predicate.evaluate(with: string)
    return number
}
public func inputPHIdcardis12Num(_ string: String) -> Bool {
    let regex = "^([0-9]{3})([0-3])([0-9]{8})"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let inputString = predicate.evaluate(with: string)
    return inputString
}
func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

// 中英文标点符号正则表达式
public func onlyInputPunctuationCharacter(_ string: String) -> Bool {
    let numString = "\\p{P}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", numString)
    let number = predicate.evaluate(with: string)
    return number
}

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String

    init?(_ pattern: String) {
        self.pattern = pattern
        do {
            try self.internalExpression = NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        } catch _ {
            return nil
        }
    }

    func test(_ input: String) -> Bool {
        let matches = self.internalExpression.matches(in: input, options: .reportProgress, range: NSRange.init(location: 0, length: input.count))
        return matches.count > 0
    }
}

func test(input: String, pattern: String) -> Bool {
    return Regex(pattern)?.test(input) ?? false
}
//if let match = name.rangeOfString("ski$", options: .RegularExpressionSearch) {
//    println("\(name) is probably polish")
//}
