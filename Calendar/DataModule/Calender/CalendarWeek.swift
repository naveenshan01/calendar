//
//  CalendarWeek.swift
//  Calendar
//
//  Created by Naveen Shan on 30/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class CalendarWeek: NSObject {
    
    /**
     The date used to create the calender week.
     which is used for finding next and previous week.
     */
    private var _referenceDate: Date?
    
    /**
     The days in the current week.
     */
    public var calendarDays: [CalendarDay] {
        get {
            return _calendarDays
        }
    }
    private var _calendarDays: [CalendarDay] = []

    //MARK: -

    convenience init(referenceDate: Date, isFirstWeekOfMonth: Bool = false) {
        self.init()
        
        _referenceDate = referenceDate
        populateDaysInThisWeek(isFirstWeekOfMonth: isFirstWeekOfMonth)
    }
    
    //MARK: -
    
    func populateDaysInThisWeek(isFirstWeekOfMonth: Bool = false) {
        _calendarDays.removeAll()
        
        guard let referenceDate = _referenceDate else {
            return
        }
        
        // create calendar
        let calendar = Calendar.current
        
        // date components
        let referenceDateComponent = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: referenceDate)

        // range of dates in this week
        let thisWeekDateRange = calendar.range(of: Calendar.Component.day, in: Calendar.Component.weekOfMonth, for: referenceDate)
        
        if thisWeekDateRange != nil {
            // start day interval from reference date to beginning of week
            let startDayInterval = (thisWeekDateRange?.lowerBound)! - (referenceDateComponent.day)!
            
            // date for beginning day of this week, ie. this week's Sunday's date
            let beginningOfWeek = calendar.date(byAdding: Calendar.Component.day, value: startDayInterval, to: referenceDate)
            
            if beginningOfWeek != nil {
                // the range of available dates in this week
                let range = ((thisWeekDateRange?.upperBound)! - (thisWeekDateRange?.lowerBound)!)
                for i in 0..<range {
                    let date = calendar.date(byAdding: Calendar.Component.day, value: i, to: beginningOfWeek!)
                    _calendarDays.append(CalendarDay(referenceDate: date))
                }
                
                let numberOfDaysInWeek = 7
                if isFirstWeekOfMonth && _calendarDays.count < numberOfDaysInWeek {
                    // Need to append some empty dates in front.
                    for _ in 0..<(numberOfDaysInWeek - _calendarDays.count) {
                        _calendarDays.insert(CalendarDay(), at: 0)
                    }
                }
            }
        }
    }
}
