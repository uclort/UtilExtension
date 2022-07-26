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

    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date {
        Date(timeIntervalSince1970: timeIntervalValue)
    }

    /// 转成 Date 字符串
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String {
        let dateFormatter = DateFormatter()
        var dateFormat = ""
        switch type {
        case .custom(let format):
            dateFormat = format
        default:
            dateFormat = type.rawValue
        }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: toDate())
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

    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date {
        intValue.util.toDate()
    }

    /// 转成 Date 字符串
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String {
        intValue.util.toDateString(type: type)
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

    var floatValue: Float {
        Float(util)
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
    
    var doubleValue: Double {
        Double(util)
    }

    var floatValue: Float {
        Float(util)
    }

    var cgFloatValue: CGFloat {
        CGFloat(util)
    }
}

public extension HmUtils where Util == TimeInterval {
    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date {
        intValue.util.toDate()
    }

    /// 转成 Date 字符串
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String {
        intValue.util.toDateString(type: type)
    }
}
