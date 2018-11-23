//
//  FadeInAnimationTransition.swift
//  SearchApp
//
//  Created by Nagib Azad on 23/11/18.
//  Copyright © 2018 Nagib Bin Azad. All rights reserved.
//

import Foundation
import UIKit

class FadeInAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController   = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1.0
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
