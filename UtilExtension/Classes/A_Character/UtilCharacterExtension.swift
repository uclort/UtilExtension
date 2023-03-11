//
//  UtilCharacterExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionUtil where Util == Character {
    var intValue: Int? {
        Int(String(util))
    }

    var stringValue: String {
        String(util)
    }

    /// 字母转成小写字符
    var lowercased: Character {
        String(util).lowercased().first!
    }

    /// 字母转成大写字符
    var uppercased: Character {
        String(util).uppercased().first!
    }
}
