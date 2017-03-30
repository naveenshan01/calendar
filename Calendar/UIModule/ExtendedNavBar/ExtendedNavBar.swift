//
//  ExtendedNavBar.swift
//  Calendar
//
//  Created by Naveen Shan on 29/01/17.
//  Copyright © 2017 NanuSoft. All rights reserved.
//

import UIKit

class ExtendedNavBar: UINavigationBar {
    
    @IBInspectable var extendBar: Bool = false {
        didSet {
            extendNavigationBar()
        }
    }
    
    private func extendNavigationBar() {
        if extendBar {
            // Translucency of the navigation bar is disabled so that it matches with
            // the non-translucent background of the extension view.
            isTranslucent = false
            // ExtendedNavBarView will draw its own hairline.
            shadowImage = #imageLiteral(resourceName: "TransparentPixel")
            // "Pixel" is a solid white 1x1 image.
            setBackgroundImage(
                #imageLiteral(resourceName: "ShadowPixel"), for: .default)
        }
    }

}
