//
//  HmNumberExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

#if os(iOS)
import UIKit
#endif

public extension HmUtils where Util == Int {
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

public extension HmUtils where Util == Int64 {
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

public extension HmUtils where Util == Float {
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

public extension HmUtils where Util == Double {
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

public extension HmUtils where Util == CGFloat {
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

public extension HmUtils where Util == Bool {
    var intValue: Int {
        return util ? 1 : 0
    }

    var stringValue: String {
        return util ? "true" : "false"
    }
}

public extension HmUtils where Util: FloatingPoint {
    var ceil: Util {
        return Foundation.ceil(util)
    }

    var floor: Util {
        return Foundation.floor(util)
    }
}
