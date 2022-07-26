//
//  HmNameSpace.swift
//  SwiftUtil
//
//  Created by 侯猛 on 2022/7/13.
//

import Foundation
#if os(iOS)
import UIKit
#endif

// MARK: 通用

public struct HmUtils<Util> {
    public var util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol HmUtilsType {
    associatedtype WrappableType
    var util: WrappableType { get }
    static var util: WrappableType.Type { get }
}

public extension HmUtilsType {
    var util: HmUtils<Self> {
        HmUtils(self)
    }
    static var util: HmUtils<Self>.Type {
        HmUtils.self
    }
}

// MARK: 数组

public struct HmArrayUtils<Util> {
    public let util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol HmArrayUtilsType {
    associatedtype WrappableType
    var util: WrappableType { get }
}

public extension HmArrayUtilsType {
    var util: HmArrayUtils<Self> {
        HmArrayUtils(self)
    }
}

extension Array: HmArrayUtilsType {}
extension Dictionary: HmUtilsType {}
extension String: HmUtilsType {}
extension Int: HmUtilsType {}
extension Int64: HmUtilsType {}
extension Double: HmUtilsType {}
extension Float: HmUtilsType {}
extension CGRect: HmUtilsType {}
extension NSAttributedString: HmUtilsType {}
extension Data: HmUtilsType {}
extension Device: HmUtilsType {}

#if os(iOS)
extension UIView: HmUtilsType {}
extension UIViewController: HmUtilsType {}
extension UIApplication: HmUtilsType {}
#endif
