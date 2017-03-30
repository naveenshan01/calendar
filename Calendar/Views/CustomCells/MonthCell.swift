//
//  MonthCell.swift
//  Calendar
//
//  Created by Naveen Shan on 01/02/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class MonthCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var stackView: UIStackView!
    
    public var calendarMonth: CalendarMonth? {
        didSet {
            updateView()
        }
    }
    
    //MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearViews()
    }
    
    private func clearViews() {
        for i in 0..<stackView.arrangedSubviews.count  {
            let weekView = stackView.arrangedSubviews[i] as! WeekView
            weekView.calendarWeek = nil
        }
    }
    
    //MARK: -
    
    private func updateView() {
        titleLabel.text = calendarMonth?.displayName
        
        guard let calendarWeeks = calendarMonth?.calendarWeeks, calendarWeeks.count > 0 else {
            return
        }
        
        // Handle maxmum of 6 weeks in a month.
        let weekViews = stackView.arrangedSubviews
        for i in 0 ..< weekViews.count  {
            let weekView = weekViews[i] as! WeekView
            if (i < calendarWeeks.count) {
                weekView.isHidden = false
                weekView.calendarWeek = calendarWeeks[i]
            }
            else {
                weekView.isHidden = true
                weekView.calendarWeek = nil
            }
        }
    }
}
