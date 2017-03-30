//
//  WeekView.swift
//  Calendar
//
//  Created by Naveen Shan on 01/02/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class WeekView: UIView {
    @IBOutlet fileprivate weak var stackView: UIStackView!
    
    public var calendarWeek: CalendarWeek? {
        didSet {
            updateView()
        }
    }
    
    //MARK: -
    
    private func clearViews() {
        for i in 0..<stackView.arrangedSubviews.count  {
            let dayView = stackView.arrangedSubviews[i] as! DayView
            dayView.calendarDay = nil
        }
    }
    
    //MARK: -
    
    private func updateView() {
        clearViews()
        
        guard let calendarDays = calendarWeek?.calendarDays, calendarDays.count > 0 else {
            return
        }
        
        for i in 0..<calendarDays.count  {
            let dayView = stackView.arrangedSubviews[i] as! DayView
            dayView.calendarDay = calendarDays[i]
        }
    }
}
