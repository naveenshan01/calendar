//
//  DayView.swift
//  Calendar
//
//  Created by Naveen Shan on 30/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class DayView: UIView {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    public var calendarDay: CalendarDay? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - 
    
    private func updateView() {
        titleLabel.text = calendarDay?.day
        titleLabel.textColor = (calendarDay?.isWeekEnd ?? false) ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        showCircle(show: (calendarDay?.isToday ?? false))
    }
    
    var circleLayer: CALayer?
    private func showCircle(show: Bool) {
        if show {
            if circleLayer == nil {
                circleLayer = CALayer()
                circleLayer?.masksToBounds = true
                circleLayer?.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.4705882353, blue: 0.7921568627, alpha: 1).cgColor
            }
            
            layer.insertSublayer(circleLayer!, at: 0)
        }
        else {
            circleLayer?.removeFromSuperlayer()
            circleLayer = nil
        }
    }
    
    
    //MARK: - Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = min(self.bounds.size.width, self.bounds.size.height) - 5 //(padding)
        let radius = (size / 2)
        circleLayer?.cornerRadius = radius
        
        let labelCenterX = self.bounds.size.width / 2
        let labelCenterY = self.bounds.size.height / 2
        circleLayer?.frame = CGRect(x: (labelCenterX - radius), y: (labelCenterY - radius), width: size, height: size)
    }
}
