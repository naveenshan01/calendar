//
//  CalendarHomeViewController+DataSource.swift
//  Calendar
//
//  Created by Naveen Shan on 30/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

extension CalendarHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - CollectionView Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.calendarMonths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: monthCell, for: indexPath as IndexPath) as! MonthCell
        
        if viewModel.calendarMonths.count > indexPath.item {
            cell.calendarMonth = viewModel.calendarMonths[indexPath.item]
        }
        
        return cell
    }
    
    // MARK: -
    
    func collectionView(_ collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize  {
        var height = 0 as CGFloat
        if viewModel.calendarMonths.count > indexPath.item {
            let monthHeadingHeight = 40 as CGFloat
            let weekCellHeight = 60 as CGFloat
            let calendarMonth = viewModel.calendarMonths[indexPath.item]
            height = (CGFloat(calendarMonth.calendarWeeks.count) * weekCellHeight)
            height += monthHeadingHeight
        }
        
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
