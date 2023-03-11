//
//  UtilExtensionNamespace.swift
//  SwiftUtil
//
//  Created by 侯猛 on 2022/7/13.
//

import Foundation
import UIKit
import MapKit

// MARK: - 通用 -

public struct UclortExtensionUtil<Util> {
    public var util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol UclortExtensionUtilType {
    associatedtype UclortWrappableType
    var util: UclortWrappableType { get }
    static var util: UclortWrappableType.Type { get }
}

public extension UclortExtensionUtilType {
    var util: UclortExtensionUtil<Self> {
        UclortExtensionUtil(self)
    }

    static var util: UclortExtensionUtil<Self>.Type {
        UclortExtensionUtil.self
    }
}

// MARK: - 数组 -

public struct UclortExtensionArrayUtil<Util> {
    public var util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol UclortExtensionArrayUtilType {
    associatedtype UclortWrappableType
    var util: UclortWrappableType { get }
}

public extension UclortExtensionArrayUtilType {
    var util: UclortExtensionArrayUtil<Self> {
        UclortExtensionArrayUtil(self)
    }
}

// MARK: - 对象 -

public struct UclortExtensionDictionaryUtil<Util> {
    public let util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol UclortExtensionDictionaryUtilType {
    associatedtype UclortWrappableType
    var util: UclortWrappableType { get }
}

public extension UclortExtensionDictionaryUtilType {
    var util: UclortExtensionDictionaryUtil<Self> {
        UclortExtensionDictionaryUtil(self)
    }
}

// MARK: - 可变 -

public class UclortExtensionVariableUtil<Util> {
    public var util: Util
    public init(_ util: Util) {
        self.util = util
    }
}

public protocol UclortExtensionVariableUtilType {
    associatedtype UclortWrappableType
    var util: UclortWrappableType { get }
    static var util: UclortWrappableType.Type { get }
}

public extension UclortExtensionVariableUtilType {
    var util: UclortExtensionVariableUtil<Self> {
        UclortExtensionVariableUtil(self)
    }

    static var util: UclortExtensionVariableUtil<Self>.Type {
        UclortExtensionVariableUtil.self
    }
}

// MARK: - Extension -

extension Array: UclortExtensionArrayUtilType {}

extension Dictionary: UclortExtensionDictionaryUtilType {}

extension String: UclortExtensionUtilType {}
extension Int: UclortExtensionUtilType {}
extension UInt: UclortExtensionUtilType {}
extension Int64: UclortExtensionUtilType {}
extension Double: UclortExtensionUtilType {}
extension Float: UclortExtensionUtilType {}
extension Bool: UclortExtensionUtilType {}
extension CGFloat: UclortExtensionUtilType {}
extension CGRect: UclortExtensionUtilType {}
extension UIEdgeInsets: UclortExtensionUtilType {}
extension Data: UclortExtensionUtilType {}
extension Character: UclortExtensionUtilType {}
extension URL: UclortExtensionUtilType {}
extension Date: UclortExtensionUtilType {}
extension CLLocationCoordinate2D: UclortExtensionUtilType {}

extension NSObject: UclortExtensionVariableUtilType {}
