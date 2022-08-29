//
//  HmDateExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension Date {
    
    /// 日历
    var calendar: Calendar {
        Calendar(identifier: Calendar.current.identifier)
    }
    /// 年
    var util_year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
}

public extension HmVariableUtils where Util == Date {
    /// 日历
    var calendar: Calendar {
        Calendar(identifier: Calendar.current.identifier)
    }
    
    /// 时代
    var era: Int {
        calendar.component(.era, from: util)
    }

    /// 年
    var year: Int {
        get {
            return calendar.component(.year, from: util)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: util)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 月
    var month: Int {
        get {
            return calendar.component(.month, from: util)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: util)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = calendar.component(.month, from: util)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 日
    var day: Int {
        get {
            return calendar.component(.day, from: util)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: util)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: util)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 周
    var weekday: Int {
        return calendar.component(.weekday, from: util)
    }
    
    /// 小时
    var hour: Int {
        get {
            return calendar.component(.hour, from: util)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: util)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: util)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 分钟
    var minute: Int {
        get {
            return calendar.component(.minute, from: util)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: util)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: util)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 秒
    var second: Int {
        get {
            return calendar.component(.second, from: util)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: util)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: util)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 纳秒
    var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: util)
        }
        set {
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: util)!
            #endif
            guard allowedRange.contains(newValue) else { return }

            let currentNanoseconds = calendar.component(.nanosecond, from: util)
            let nanosecondsToAdd = newValue - currentNanoseconds

            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: util) {
                util = date
            }
        }
    }
    
    /// 微秒
    var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: util) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: util)!
            #endif
            guard allowedRange.contains(nanoSeconds) else { return }

            if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: util) {
                util = date
            }
        }
    }
    
    /// 是否为今天
    var isInToday: Bool {
        calendar.isDateInToday(util)
    }
    
    /// 是否为昨天
    var isInYesterday: Bool {
        calendar.isDateInYesterday(util)
    }
    
    /// 是否为明天
    var isInTomorrow: Bool {
        calendar.isDateInTomorrow(util)
    }
    
    /// 是否为周末
    var isInWeekend: Bool {
        calendar.isDateInWeekend(util)
    }
    
    /// 是否为工作日
    var isWorkday: Bool {
        !calendar.isDateInWeekend(util)
    }

    /// 是否为当周
    var isInCurrentWeek: Bool {
        calendar.isDate(util, equalTo: Date(), toGranularity: .weekOfYear)
    }

    /// 是否为当月
    var isInCurrentMonth: Bool {
        calendar.isDate(util, equalTo: Date(), toGranularity: .month)
    }

    /// 是否为当年
    var isInCurrentYear: Bool {
        calendar.isDate(util, equalTo: Date(), toGranularity: .year)
    }

    /// 是否为未来时间
    var isInFuture: Bool {
        return util > Date()
    }
    
    /// 是否为过去时间
    var isInPast: Bool {
        return util < Date()
    }
    
    /// 最近 5 分钟
    var nearestFiveMinutes: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: util)
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// 最近 10 分钟
    var nearestTenMinutes: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: util)
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// 最近一刻钟
    var nearestQuarterHour: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: util)
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// 最近半小时
    var nearestHalfHour: Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: util)
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// 最近一小时
    var nearestHour: Date {
        let min = calendar.component(.minute, from: util)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = calendar.date(from: calendar.dateComponents(components, from: util))!

        if min < 30 {
            return date
        }
        return calendar.date(byAdding: .hour, value: 1, to: date)!
    }

    /// 昨天
    var yesterday: Date {
        calendar.date(byAdding: .day, value: -1, to: util) ?? Date()
    }
    
    /// 明天
    var tomorrow: Date {
        calendar.date(byAdding: .day, value: 1, to: util) ?? Date()
    }
    
    /// 时间戳
    var unixTimestamp: Double {
        util.timeIntervalSince1970
    }
    
    /// 间隔多少秒
    func secondsSince(_ date: Date) -> Double {
        util.timeIntervalSince(date)
    }
    
    /// 间隔多少分钟
    func minutesSince(_ date: Date) -> Double {
        util.timeIntervalSince(date) / 60
    }
    
    /// 间隔多少小时
    func hoursSince(_ date: Date) -> Double {
        util.timeIntervalSince(date) / 3600
    }
    
    /// 间隔多少天
    func daysSince(_ date: Date) -> Double {
        util.timeIntervalSince(date) / (3600 * 24)
    }
    
    /// 创建时间
    static func create(
        calendar: Calendar? = Calendar.current,
        timeZone: TimeZone? = NSTimeZone.default,
        era: Int? = Date().util.era,
        year: Int? = Date().util.year,
        month: Int? = Date().util.month,
        day: Int? = Date().util.day,
        hour: Int? = Date().util.hour,
        minute: Int? = Date().util.minute,
        second: Int? = Date().util.second,
        nanosecond: Int? = Date().util.nanosecond) -> Date?
    {
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond

        guard let date = calendar?.date(from: components) else { return nil }
        return date
    }
    
    /// 返回增量后的时间
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        calendar.date(byAdding: component, value: value, to: util)!
    }

    /// 格式化时间
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: util)
    }

    /// 是否位于两个时间之内
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false)
    /// - Returns: true if the date is between the two given dates.
    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(util).rawValue * util.compare(endDate).rawValue >= 0
        }
        return startDate.compare(util).rawValue * util.compare(endDate).rawValue > 0
    }
}
