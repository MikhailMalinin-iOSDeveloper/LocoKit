//
//  MiscTools.swift
//  LocoKit
//
//  Created by Matt Greenfield on 4/12/17.
//  Copyright © 2017 Big Paua. All rights reserved.
//

import Foundation

public func onMain(_ closure: @escaping () -> ()) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}

public extension Comparable {
    mutating func clamp(min: Self, max: Self) {
        if self < min { self = min }
        if self > max { self = max }
    }
    func clamped(min: Self, max: Self) -> Self {
        var result = self
        if result < min { result = min }
        if result > max { result = max }
        return result
    }
}

public extension UUID {
    var shortString: String {
        return String(uuidString.split(separator: "-")[0])
    }
}

public extension DateInterval {
    var middle: Date {
        return start + duration * 0.5
    }

    func contains(_ other: DateInterval) -> Bool {
        if let overlap = intersection(with: other), overlap == other {
            return true
        }
        return false
    }
    
    var containsNow: Bool {
        return contains(Date())
    }
}

public extension Calendar {
    func previousDay(from date: Date) -> Date { self.date(byAdding: .day, value: -1, to: date)! }
    func nextDay(from date: Date) -> Date { self.date(byAdding: .day, value: 1, to: date)! }
}

public extension Date {
    var age: TimeInterval { return -timeIntervalSinceNow }
    func isToday(in calendar: Calendar = Calendar.current) -> Bool { calendar.isDateInToday(self) }
    func isYesterday(in calendar: Calendar = Calendar.current) -> Bool { calendar.isDateInYesterday(self) }
    func isTomorrow(in calendar: Calendar = Calendar.current) -> Bool { calendar.isDateInTomorrow(self) }
    func nextDay(in calendar: Calendar = Calendar.current) -> Date { calendar.nextDay(from: self) }
    func previousDay(in calendar: Calendar = Calendar.current) -> Date { calendar.previousDay(from: self) }
    func nextWeek(in calendar: Calendar = Calendar.current) -> Date { calendar.date(byAdding: .weekOfYear, value: 1, to: self)! }
    func startOfDay(in calendar: Calendar = Calendar.current) -> Date { calendar.startOfDay(for: self) }
    func endOfDay(in calendar: Calendar = Calendar.current) -> Date { nextDay(in: calendar).startOfDay(in: calendar) }
    func sinceStartOfDay(in calendar: Calendar = Calendar.current) -> TimeInterval { timeIntervalSince(startOfDay(in: calendar)) }
    func isSameDayAs(_ date: Date) -> Bool { return Calendar.current.isDate(date, inSameDayAs: self) }
    func isSameMonthAs(_ date: Date) -> Bool { return Calendar.current.isDate(date, equalTo: self, toGranularity: .month) }
}

public extension TimeInterval {
    static var oneMinute: TimeInterval { return 60 }
    static var oneHour: TimeInterval { return oneMinute * 60 }
    static var oneDay: TimeInterval { return oneHour * 24 }
    static var oneWeek: TimeInterval { return oneDay * 7 }
    static var oneMonth: TimeInterval { return oneDay * 30 }
    static var oneYear: TimeInterval { return oneDay * 365 }
}

extension Data {
    var hexString: String {
        return map { String(format: "%02.2hhx", $0) }.joined()
    }
}
