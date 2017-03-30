//
//  CalendarDay.swift
//  Calendar
//
//  Created by Naveen Shan on 30/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class CalendarDay: NSObject {
    /**
     The date component for the calender day.
     */
    private var _referenceDatecomponent: DateComponents?
    
    //MARK: - Public Interface Methods
    
    public var isEmpty: Bool {
        get {
            return (_referenceDatecomponent == nil)
        }
    }
    
    public var isToday: Bool {
        get {
             return (date != nil) ? Calendar.current.isDateInToday(date!) : false
        }
    }
    
    public var isWeekEnd: Bool {
        get {
            // 1 = Sunday and 7 = Saturday
            // which may vary based on calendar type currently its safe because we use georgian calendar.
            return (_referenceDatecomponent?.weekday == 1 || _referenceDatecomponent?.weekday == 7)
        }
    }
    
    public var date: Date? {
        get {
            return _referenceDatecomponent?.date
        }
    }
    
    public var day: String {
        get {
            return (_referenceDatecomponent != nil) ? String(format:"%d",_referenceDatecomponent!.day!) : ""
        }
    }
    
    //MARK: -
    
    convenience init(referenceDate: Date?) {
        self.init()
        
        createDateComponent(date: referenceDate)
    }
    
    //MARK: -

    private func createDateComponent(date: Date?) {
        _referenceDatecomponent = nil
        
        guard let referenceDate = date  else {
            return
        }
        
        // date components
        _referenceDatecomponent = Calendar.current.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.weekday, Calendar.Component.year], from: referenceDate)
        _referenceDatecomponent?.calendar = Calendar.current
    }
}
