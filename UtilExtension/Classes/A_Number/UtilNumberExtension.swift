//
//  HmNumberExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension UclortExtensionUtil where Util == Int {
    var stringValue: String {
        "\(util)"
    }

    var int64Value: Int64 {
        Int64(util)
    }

    var boolValue: Bool {
        util > 0
    }

    var doubleValue: Double {
        Double(util)
    }

    var floatValue: Float {
        Float(util)
    }

    var cgFloatValue: CGFloat {
        CGFloat(util)
    }

    var timeIntervalValue: TimeInterval {
        TimeInterval(util)
    }
}

public extension UclortExtensionUtil where Util == UInt {
    var stringValue: String {
        "\(util)"
    }
    
    var intValue: Int {
        Int(util)
    }
    
    var int64Value: Int64 {
        Int64(util)
    }

    var boolValue: Bool {
        util > 0
    }

    var doubleValue: Double {
        Double(util)
    }

    var floatValue: Float {
        Float(util)
    }

    var cgFloatValue: CGFloat {
        CGFloat(util)
    }

    var timeIntervalValue: TimeInterval {
        TimeInterval(util)
    }
}

public extension UclortExtensionUtil where Util == Int64 {
    var stringValue: String {
        "\(util)"
    }

    var intValue: Int {
        Int(util)
    }

    var boolValue: Bool {
        util > 0
    }

    var doubleValue: Double {
        Double(util)
    }

    var floatValue: Float {
        Float(util)
    }

    var cgFloatValue: CGFloat {
        CGFloat(util)
    }

    var timeIntervalValue: TimeInterval {
        TimeInterval(util)
    }
}

public extension UclortExtensionUtil where Util == Float {
    var stringValue: String {
        "\(util)"
    }

    var intValue: Int {
        Int(util)
    }

    var int64Value: Int64 {
        Int64(util)
    }

    var boolValue: Bool {
        util > 0
    }

    var doubleValue: Double {
        Double(util)
    }

    var cgFloatValue: CGFloat {
        CGFloat(util)
    }
}

public extension UclortExtensionUtil where Util == Double {
    var stringValue: String {
        "\(util)"
    }

    var intValue: Int {
        Int(util)
    }

    var int64Value: Int64 {
        Int64(util)
    }

    var boolValue: Bool {
        util > 0
    }

    var floatValue: Float {
        Float(util)
    }

    var cgFloatValue: CGFloat {
        CGFloat(util)
    }
}

public extension UclortExtensionUtil where Util == CGFloat {
    var stringValue: String {
        "\(util)"
    }

    var intValue: Int {
        Int(util)
    }

    var int64Value: Int64 {
        Int64(util)
    }

    var boolValue: Bool {
        util > 0
    }

    var doubleValue: Double {
        Double(util)
    }

    var floatValue: Float {
        Float(util)
    }
}

public extension UclortExtensionUtil where Util == Bool {
    var intValue: Int {
        return util ? 1 : 0
    }

    var stringValue: String {
        return util ? "true" : "false"
    }
}

public extension UclortExtensionUtil where Util: FloatingPoint {
    var ceil: Util {
        return Foundation.ceil(util)
    }

    var floor: Util {
        return Foundation.floor(util)
    }
}


public extension UclortExtensionUtil where Util == Decimal {
    var nsDecimalNumber: NSDecimalNumber {
        util as NSDecimalNumber
    }
    
    var stringValue: String {
        nsDecimalNumber.stringValue
    }

    var int64Value: Int64 {
        nsDecimalNumber.int64Value
    }

    var boolValue: Bool {
        nsDecimalNumber.boolValue
    }

    var doubleValue: Double {
        nsDecimalNumber.doubleValue
    }

    var floatValue: Float {
        nsDecimalNumber.floatValue
    }

    var cgFloatValue: CGFloat {
        CGFloat(floatValue)
    }

    var timeIntervalValue: TimeInterval {
        TimeInterval(doubleValue)
    }
}
