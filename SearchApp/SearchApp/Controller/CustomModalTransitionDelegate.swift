//
//  CustomModalTransitionDelegate.swift
//  SearchApp
//
//  Created by Nagib Azad on 23/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit

class CustomModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeInAnimationTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeOutAnimationTransition()
    }
}
