//
//  CalendarHomeViewController.swift
//  Calendar
//
//  Created by Naveen Shan on 29/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

public let monthCell = "MonthCell"

class CalendarHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viewModel: CalendarHomeViewModel!
    
    //MARK: - View LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // since we load the currentDate month as a center of datasource we need to scroll to the center cell to make current month display by default.
        let currentMonthCell = IndexPath(item: (viewModel.calendarMonths.count / 2), section: 0)
        collectionView.scrollToItem(at: currentMonthCell, at: UICollectionViewScrollPosition.top, animated: false)
    }
    
    //MARK: - View Methods

    private func initializeView() {
        title = NSLocalizedString("Calendar", comment: "")
        viewModel.populateInitialMonths()
        
        let nib = UINib(nibName: monthCell, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: monthCell)
    }
    
    fileprivate func scrollCollectionViewToCenter() {
        let contentHeight = collectionView.contentSize.height
        let collectionViewCenter = (contentHeight / 2)

        collectionView.contentOffset = CGPoint(x: collectionView.contentOffset.x, y: collectionViewCenter)
    }
}

//MARK: - UIScrollView Delegate

extension CalendarHomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentOffsetY = collectionView.contentOffset.y;
        let contentHeight = collectionView.contentSize.height;
        let viewHeight = collectionView.frame.size.height;
        if contentHeight == 0 { // Means no content
            return
        }
        
        if (currentOffsetY > (contentHeight - viewHeight)) {
            // Reaches the last page of collection view.
            // Loading more content at the bottom and scroll back to center.
            viewModel.updateWithFutureMonths()
            
            scrollCollectionViewToCenter()
        }
        else if (currentOffsetY < viewHeight) {
            // Reaches the first page of collection view.
            // Loading more content at the top and scroll back to center.
            viewModel.updateWithPastMonths()
            
            scrollCollectionViewToCenter()
        }
    }
}

