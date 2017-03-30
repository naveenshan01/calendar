//
//  CalendarHomeViewModel.swift
//  Calendar
//
//  Created by Naveen Shan on 31/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class CalendarHomeViewModel: NSObject {
    /**
     The calendar months used as the datasource.
     */
    var calendarMonths: [CalendarMonth]! = Array()

    public func populateInitialMonths() {
        var month = EnglishCalendar.currentMonth()
        // Add Current Months
        calendarMonths.append(month)
        
        // Add Previous Months
        for _ in 1...5 {
            month = month.previousMonth
            calendarMonths.insert(month, at: 0)
        }
        // Add Future Months
        month = calendarMonths.last!
        for _ in 1...5 {
            month = month.nextMonth
            calendarMonths.append(month)
        }
        NSLog("%@",calendarMonths)
    }
    
    /**
     Add 4 future months to the calendarMonths datasource
     and remove the old months
    */
    public func updateWithFutureMonths() {
        var latestMonth = calendarMonths.last
        for _ in 1...4 {
            calendarMonths.remove(at: 0)
            latestMonth = latestMonth?.nextMonth
            calendarMonths.append(latestMonth!)
        }
        NSLog("%@",calendarMonths)
    }
    
    /**
     Add 4 past months to the calendarMonths datasource
     and remove the latest months
     */
    public func updateWithPastMonths() {
        var oldMonth = calendarMonths.first
        for _ in 1...4 {
            calendarMonths.removeLast()
            oldMonth = oldMonth?.previousMonth
            calendarMonths.insert(oldMonth!, at: 0)
        }
        
        NSLog("%@",calendarMonths)
    }
}
