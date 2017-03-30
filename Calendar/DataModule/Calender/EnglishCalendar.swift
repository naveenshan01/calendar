//
//  EnglishCalendar.swift
//  Calendar
//
//  Created by Naveen Shan on 30/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class EnglishCalendar: NSObject {
    
    class func currentMonth() -> CalendarMonth {
        let currentDate = Date()
        return CalendarMonth(referenceDate: currentDate)
    }

    class func startOfMonth() -> Date  {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.month = 1
        return Calendar.current.date(from: dateComponent)!
    }
}
