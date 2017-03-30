//
//  Date+Calendar.swift
//  Calendar
//
//  Created by Naveen Shan on 31/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: -
    
    func dateComponents() -> DateComponents {
        return Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month], from: self)
    }
    
    // MARK: -
    
    func nextWeekend() -> DateInterval {
        return Calendar.current.nextWeekend(startingAfter: self)!
    }
    
    func previousWeekend() -> DateInterval {
        return Calendar.current.nextWeekend(startingAfter: self, direction: Calendar.SearchDirection.backward)!
    }
    
    func currentWeekend() -> DateInterval {
        return Calendar.current.dateIntervalOfWeekend(containing: self)!
    }
    
    // MARK: -
    
    func startOfMonth() -> Date {
        let firstDate = Calendar.current.startOfDay(for: self)
        return Calendar.current.date(from: firstDate.dateComponents())!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
