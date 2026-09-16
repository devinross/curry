//
//  NSDate+TKCategory.swift
//  Created by Devin Ross on 7/28/09.
//
/*

curry || https://github.com/devinross/curry

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*/

import Foundation


/// Calendar used by the component helpers, matching the Objective-C original.
private func gregorianCalendar(_ timeZone: TimeZone) -> Calendar {
	var calendar = Calendar(identifier: .gregorian)
	calendar.timeZone = timeZone
	return calendar
}

private func currentCalendar(_ timeZone: TimeZone) -> Calendar {
	var calendar = Calendar.current
	calendar.timeZone = timeZone
	return calendar
}


/** Additional functionality for `NSDate`. */
extension NSDate {
	
	// MARK: - Yesterday
	
	/** Creates and returns a new date set to the previous day and current time. */
	@objc public static var yesterday: Date? {
		NSDate.yesterday(with: TimeZone.current)
	}
	
	/** Creates and returns a new date set to the previous day and current time.
	@param timeZone The time zone to respect.
	*/
	@objc(yesterdayWithTimeZone:)
	public static func yesterday(with timeZone: TimeZone) -> Date? {
		shiftingToday(byDays: -1, timeZone: timeZone)
	}
	
	// MARK: - Tomorrow
	
	/** Creates and returns a new date set to tomorrow's day and current time. */
	@objc public static var tomorrow: Date? {
		NSDate.tomorrow(with: TimeZone.current)
	}
	
	/** Creates and returns a new date set to tomorrow's day and current time.
	@param timeZone The time zone to respect.
	*/
	@objc(tomorrowWithTimeZone:)
	public static func tomorrow(with timeZone: TimeZone) -> Date? {
		shiftingToday(byDays: 1, timeZone: timeZone)
	}
	
	private static func shiftingToday(byDays days: Int, timeZone: TimeZone) -> Date? {
		var components = (Date() as NSDate).dateComponents(with: timeZone)
		components.day = (components.day ?? 0) + days
		return NSDate.date(with: components)
	}
	
	// MARK: - Month
	
	/** Creates and returns a new date set to the current month date. */
	@objc public static var month: Date? {
		(Date() as NSDate).monthDate(with: TimeZone.current)
	}
	
	/** Creates and returns a new date set to the current month date.
	@param timeZone The time zone to respect.
	*/
	@objc(monthWithTimeZone:)
	public static func month(with timeZone: TimeZone) -> Date? {
		(Date() as NSDate).monthDate(with: timeZone)
	}
	
	/** Creates and returns a new date set to the first day of the month from the date object. */
	@objc public var monthDate: Date? {
		monthDate(with: TimeZone.current)
	}
	
	/** Creates and returns a new date set to the first day of the month from the date object.
	@param timeZone Time Zone for month.
	*/
	@objc(monthDateWithTimeZone:)
	public func monthDate(with timeZone: TimeZone) -> Date? {
		let calendar = gregorianCalendar(timeZone)
		var components = calendar.dateComponents([.year, .month], from: self as Date)
		components.day = 1
		return calendar.date(from: components)
	}
	
	// MARK: - Between
	
	/** Returns number of months between two dates.
	@param date The other date to compare.
	*/
	@objc(monthsBetweenDate:)
	public func monthsBetween(_ date: Date) -> Int {
		monthsBetween(date, timeZone: TimeZone.current)
	}
	
	/** Returns number of months between two dates.
	@param toDate The other date to compare.
	@param timeZone The time zone to respect.
	*/
	@objc(monthsBetweenDate:timeZone:)
	public func monthsBetween(_ toDate: Date, timeZone: TimeZone) -> Int {
		
		let selfDate = self as Date
		if selfDate == toDate { return 0 }
		
		let first = selfDate < toDate ? selfDate : toDate
		let last  = selfDate < toDate ? toDate : selfDate
		
		let d1 = (first as NSDate).dateComponents(with: timeZone)
		let d2 = (last as NSDate).dateComponents(with: timeZone)
		
		let firstYear = d1.year ?? 0, firstMonth = d1.month ?? 0
		let lastYear = d2.year ?? 0, lastMonth = d2.month ?? 0
		
		if firstYear == lastYear { return lastMonth - firstMonth }
		
		var months = 12 - firstMonth
		months += lastMonth
		months += 12 * (lastYear - (firstYear + 1))
		return months
	}
	
	/** Returns number of days between the receiver and another date. */
	@objc(daysBetweenDate:)
	public func daysBetween(_ date: Date) -> Int {
		let time = timeIntervalSince(date)
		return Int((abs(time) / (60.0 * 60.0 * 24.0)) + 0.5)
	}
	
	/** Returns number of days between two dates.
	@param fromDate The date to compare.
	@param toDate The other date to compare.
	*/
	@objc(daysBetweenDate:andDate:)
	public static func daysBetween(_ fromDate: Date, and toDate: Date) -> Int {
		daysBetween(fromDate, and: toDate, timeZone: Calendar.current.timeZone)
	}
	
	/** Returns number of days between two dates.
	@param fromDate The date to compare.
	@param toDate The other date to compare.
	@param timeZone The time zone to respect.
	*/
	@objc(daysBetweenDate:andDate:timeZone:)
	public static func daysBetween(_ fromDate: Date, and toDate: Date, timeZone: TimeZone) -> Int {
		let calendar = currentCalendar(timeZone)
		guard let from = calendar.dateInterval(of: .day, for: fromDate)?.start,
		      let to = calendar.dateInterval(of: .day, for: toDate)?.start else { return 0 }
		return calendar.dateComponents([.day], from: from, to: to).day ?? 0
	}
	
	// MARK: - Same Day / Month / Year
	
	/** Returns whether the compared date shares the date with respect to the default time zone. */
	@objc(isSameDay:)
	public func isSameDay(_ anotherDate: Date) -> Bool {
		isSameDay(anotherDate, timeZone: TimeZone.current)
	}
	
	/** Returns whether the compared date shares the date with respect to the given time zone. */
	@objc(isSameDay:timeZone:)
	public func isSameDay(_ anotherDate: Date, timeZone: TimeZone) -> Bool {
		matches([.year, .month, .day], anotherDate, timeZone)
	}
	
	/** Returns whether the compared date shares the month with respect to the default time zone. */
	@objc(isSameMonth:)
	public func isSameMonth(_ anotherDate: Date) -> Bool {
		isSameMonth(anotherDate, timeZone: TimeZone.current)
	}
	
	/** Returns whether the compared date shares the month with respect to the given time zone. */
	@objc(isSameMonth:timeZone:)
	public func isSameMonth(_ anotherDate: Date, timeZone: TimeZone) -> Bool {
		matches([.year, .month], anotherDate, timeZone)
	}
	
	/** Returns whether the compared date shares the year with respect to the default time zone. */
	@objc(isSameYear:)
	public func isSameYear(_ anotherDate: Date) -> Bool {
		isSameYear(anotherDate, timeZone: TimeZone.current)
	}
	
	/** Returns whether the compared date shares the year with respect to the given time zone. */
	@objc(isSameYear:timeZone:)
	public func isSameYear(_ anotherDate: Date, timeZone: TimeZone) -> Bool {
		matches([.year], anotherDate, timeZone)
	}
	
	private func matches(_ units: Set<Calendar.Component>, _ other: Date, _ timeZone: TimeZone) -> Bool {
		let calendar = currentCalendar(timeZone)
		return calendar.dateComponents(units, from: self as Date) == calendar.dateComponents(units, from: other)
	}
	
	// MARK: - Is Today / Tomorrow / Yesterday
	
	/** Whether the date object is the same date information as the current day. */
	@objc(isToday)
	public var isToday: Bool {
		isSameDay(Date())
	}
	
	/** Whether the date object is the same date information as the current day.
	@param timeZone The time zone to respect.
	*/
	@objc(isTodayWithTimeZone:)
	public func isToday(with timeZone: TimeZone) -> Bool {
		isSameDay(Date(), timeZone: timeZone)
	}
	
	/** Whether the date object is the same date information as tomorrow. */
	@objc(isTomorrow)
	public var isTomorrow: Bool {
		isTomorrow(with: TimeZone.current)
	}
	
	/** Whether the date object is the same date information as tomorrow.
	@param timeZone The time zone to respect.
	*/
	@objc(isTomorrowWithTimeZone:)
	public func isTomorrow(with timeZone: TimeZone) -> Bool {
		guard let actualTomorrow = NSDate.tomorrow(with: timeZone) else { return false }
		return isSameDay(actualTomorrow, timeZone: timeZone)
	}
	
	/** Whether the date object is the same date information as yesterday. */
	@objc(isYesterday)
	public var isYesterday: Bool {
		isYesterday(with: TimeZone.current)
	}
	
	/** Whether the date object is the same date information as yesterday.
	@param timeZone The time zone to respect.
	*/
	@objc(isYesterdayWithTimeZone:)
	public func isYesterday(with timeZone: TimeZone) -> Bool {
		guard let actualYesterday = NSDate.yesterday(with: timeZone) else { return false }
		return isSameDay(actualYesterday, timeZone: timeZone)
	}
	
	// MARK: - Month & Year String
	
	/** The localized month and year string for the date object. */
	@objc public var monthYearString: String {
		monthYearString(with: TimeZone.current)
	}
	
	/** The localized month and year string for the date object.
	@param timeZone The time zone to respect.
	*/
	@objc(monthYearStringWithTimeZone:)
	public func monthYearString(with timeZone: TimeZone) -> String {
		let template = DateFormatter.dateFormat(fromTemplate: "yMMMM", options: 0, locale: Locale.current)
		return string(format: template ?? "MMMM yyyy", timeZone: timeZone)
	}
	
	/** The localized month string for the date object. */
	@objc public var monthString: String {
		monthString(with: TimeZone.current)
	}
	
	/** The localized month string for the date object.
	@param timeZone The time zone to respect.
	*/
	@objc(monthStringWithTimeZone:)
	public func monthString(with timeZone: TimeZone) -> String {
		string(format: "MMMM", timeZone: timeZone)
	}
	
	/** The localized year string for the date object. */
	@objc public var yearString: String {
		yearString(with: TimeZone.current)
	}
	
	/** The localized year string for the date object.
	@param timeZone The time zone to respect.
	*/
	@objc(yearStringWithTimeZone:)
	public func yearString(with timeZone: TimeZone) -> String {
		string(format: "yyyy", timeZone: timeZone)
	}
	
	private func string(format: String, timeZone: TimeZone) -> String {
		let formatter = DateFormatter()
		formatter.timeZone = timeZone
		formatter.dateFormat = format
		return formatter.string(from: self as Date)
	}
	
	// MARK: - Date Components
	
	/** Returns a date from the given component information for the gregorian calendar.
	@param components The information used to create the date.
	*/
	@objc(dateWithDateComponents:)
	public static func date(with components: DateComponents) -> Date? {
		gregorianCalendar(components.timeZone ?? TimeZone.current).date(from: components)
	}
	
	/** Returns the date components for the receiver with respect to the given time zone and gregorian calendar.
	@param timeZone The time zone to respect.
	*/
	@objc(dateComponentsWithTimeZone:)
	public func dateComponents(with timeZone: TimeZone) -> DateComponents {
		gregorianCalendar(timeZone).dateComponents(
			[.year, .month, .day, .hour, .minute, .second, .weekday, .timeZone],
			from: self as Date)
	}
	
	/** Returns a date a number of days after the receiver. */
	@objc(dateByAddingDays:)
	public func dateByAdding(days: Int) -> Date? {
		var components = DateComponents()
		components.day = days
		return Calendar.current.date(byAdding: components, to: self as Date)
	}
	
	/** Combines the day of one date with the time of another. */
	@objc(dateWithDatePart:andTimePart:)
	public static func date(withDatePart aDate: Date, andTimePart aTime: Date) -> Date? {
		
		let formatter = DateFormatter()
		
		formatter.dateFormat = "dd/MM/yyyy"
		let datePortion = formatter.string(from: aDate)
		
		formatter.dateFormat = "HH:mm"
		let timePortion = formatter.string(from: aTime)
		
		formatter.dateFormat = "dd/MM/yyyy HH:mm"
		return formatter.date(from: "\(datePortion) \(timePortion)")
	}
	
	// MARK: - First Date of Week
	
	/** The first date of the receiver's week, in the given time zone. */
	@objc(firstDateOfWeekWithTimeZone:)
	public func firstDateOfWeek(with timeZone: TimeZone) -> Date? {
		
		let calendar = currentCalendar(timeZone)
		let weekday = calendar.component(.weekday, from: self as Date)
		
		var componentsToSubtract = DateComponents()
		componentsToSubtract.timeZone = timeZone
		componentsToSubtract.day = -(weekday - calendar.firstWeekday)
		
		guard let shifted = calendar.date(byAdding: componentsToSubtract, to: self as Date) else { return nil }
		
		var components = calendar.dateComponents([.year, .month, .day], from: shifted)
		components.timeZone = timeZone
		return calendar.date(from: components)
	}
	
	/** The first date of the receiver's week, in the default time zone. */
	@objc public var firstDateOfWeek: Date? {
		firstDateOfWeek(with: TimeZone.current)
	}
	
	/** The first date of the current week, in the given time zone. */
	@objc(firstDateOfWeekWithTimeZone:)
	public static func firstDateOfWeek(with timeZone: TimeZone) -> Date? {
		(Date() as NSDate).firstDateOfWeek(with: timeZone)
	}
	
	/** The first date of the current week, in the default time zone. */
	@objc public static var firstDateOfWeek: Date? {
		(Date() as NSDate).firstDateOfWeek
	}
	
}
