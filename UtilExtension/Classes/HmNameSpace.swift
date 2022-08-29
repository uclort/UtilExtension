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
    public var util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol HmArrayUtilsType {
    associatedtype WrappableType
    var util: WrappableType { get set }
}

public extension HmArrayUtilsType {
    var util: HmArrayUtils<Self> {
        get {
            HmArrayUtils(self)
        }
        set {}
    }
}

// MARK: - 对象 -

public struct HmObjectUtils<Util> {
    public let util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol HmObjectUtilsType {
    associatedtype WrappableType
    var util: WrappableType { get }
}

public extension HmObjectUtilsType {
    var util: HmObjectUtils<Self> {
        HmObjectUtils(self)
    }
}

// MARK: UIView

public class HmVariableUtils<Util> {
    public var util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol HmVariableUtilsType {
    associatedtype WrappableType
    var util: WrappableType { get }
    static var util: WrappableType.Type { get }
}

public extension HmVariableUtilsType {
    var util: HmVariableUtils<Self> {
        HmVariableUtils(self)
    }

    static var util: HmVariableUtils<Self>.Type {
        HmVariableUtils.self
    }
}

// MARK: - Extension -

extension Array: HmArrayUtilsType {}

extension Dictionary: HmObjectUtilsType {}

extension String: HmUtilsType {}
extension Int: HmUtilsType {}
extension Int64: HmUtilsType {}
extension Double: HmUtilsType {}
extension Float: HmUtilsType {}
extension Bool: HmUtilsType {}
extension CGFloat: HmUtilsType {}
extension CGRect: HmUtilsType {}
extension NSAttributedString: HmUtilsType {}
extension Data: HmUtilsType {}
extension Character: HmUtilsType {}
extension URL: HmUtilsType {}

extension UtilDevice: HmUtilsType {}
extension UtilApplication: HmUtilsType {}

extension Date: HmVariableUtilsType {}

#if os(iOS)
extension UIStoryboard: HmUtilsType {}
extension UIScreen: HmUtilsType {}
extension UIFont: HmUtilsType {}
extension UIView: HmVariableUtilsType {}
extension UIBarButtonItem: HmVariableUtilsType {}
extension UIViewController: HmUtilsType {}
extension UIColor: HmUtilsType {}
extension UIImage: HmUtilsType {}
extension UIEdgeInsets: HmUtilsType {}
#endif
