//
//  CalendarMonth.swift
//  Calendar
//
//  Created by Naveen Shan on 30/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class CalendarMonth: NSObject {
    /**
     The date used to create the calender month.
     which is used for finding next and previous month.
     */
    private var _referenceDate: Date?
    /**
     The date component for the reference date.
     */
    private var _referenceDatecomponent: DateComponents?
    
    /**
     The weeks in the current month.
     */
    public var calendarWeeks: [CalendarWeek] {
        get {
            return _calendarWeeks
        }
    }
    private var _calendarWeeks: [CalendarWeek] = []
    
    /**
     The display name for the month.
      - Format: 'shortMonthSymbol' 'year'
      - Eg:  Jan 2017
    */
    public var displayName: String {
        get {
            if let referenceDatecomponent = _referenceDatecomponent {
                let month = Calendar.current.shortMonthSymbols[referenceDatecomponent.month! - 1]
                return month + String(format: " %d",(referenceDatecomponent.year)!)
            }
            return ""
        }
    }
    
    /**
     The month next to the current month.
     */
    public var nextMonth: CalendarMonth {
        get {
            if _nextMonth == nil {
                let next = Calendar.current.date(byAdding: Calendar.Component.month, value: 1, to: _referenceDate!)
                if next != nil {
                    _nextMonth = CalendarMonth(referenceDate: next!)
                }
                
            }
            return _nextMonth!
        }
    }
    private var _nextMonth: CalendarMonth?
    
    /**
     The month previous to the current month.
     */
    public var previousMonth: CalendarMonth {
        get {
            if _previousMonth == nil {
                let previous = Calendar.current.date(byAdding: Calendar.Component.month, value: -1, to: _referenceDate!)
                _previousMonth = CalendarMonth(referenceDate: previous!)
            }
            return _previousMonth!
        }
    }
    private var _previousMonth: CalendarMonth?
    
    //MARK: -
    
    convenience init(referenceDate: Date) {
        self.init()
        _referenceDate = referenceDate
        _referenceDatecomponent = referenceDate.dateComponents()
        createCalendarMonth()
    }
    
    //MARK: -
    
    private func createCalendarMonth() {
        _calendarWeeks.removeAll()
        
        guard let referenceDate = _referenceDate else {
            return
        }
        
        let monthStartDate = referenceDate.startOfMonth()
        let monthEndDate = referenceDate.endOfMonth()
        
        // find the next weekend interval from month start date.
        var dateInterval = monthStartDate.nextWeekend()
        if Calendar.current.isDateInWeekend(monthStartDate) {
            // month start date is a Saturday then that date got missed if we find the next weekend since Saturday is also with in the weekend.
            // handles by resetiing the next weekend with current weekend which contains month start date.
            let currentWeekendInterval = monthStartDate.currentWeekend()
            if currentWeekendInterval.start == monthStartDate {
                dateInterval = currentWeekendInterval
            }
        }
        
        var isFirstWeekOfMonth = true
        while dateInterval.start <= monthEndDate {
            let week = CalendarWeek(referenceDate: dateInterval.start, isFirstWeekOfMonth: isFirstWeekOfMonth)
            _calendarWeeks.append(week)
            
            isFirstWeekOfMonth = false
            dateInterval = dateInterval.end.nextWeekend()
        }
        let week = CalendarWeek(referenceDate: monthEndDate)
        _calendarWeeks.append(week)
    }
}

extension CalendarMonth {
    override var description: String {
        return displayName
    }
}
