//
//  UIViewControllerExtension.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/27/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit

extension UIViewController {
    func showTopBarErrorMessage(viewController: SWTopBarErrorMessage, withFrameToShow frame: CGRect, withText text: String) {
        if viewController.topBarErrorLabel.superview == nil {
            viewController.topBarErrorLabel.frame = frame
            viewController.topBarErrorLabel.text = text
            viewController.view.addSubview(viewController.topBarErrorLabel)
        }
    }
    
    func hideTopBarErrorMessage(viewController: SWTopBarErrorMessage) {
        viewController.topBarErrorLabel.removeFromSuperview()
    }
}
