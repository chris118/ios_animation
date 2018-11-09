//
//  FadeTransitionDelegate.swift
//  ios-animation
//
//  Created by Chris on 2018/11/7.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class FadeTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate  {
    private lazy var fadeAnimator = FadeAnimator()
    
    // 提供dismiss的时候使用到的动画执行对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        fadeAnimator.isPresenting = false
        return fadeAnimator
    }
    
    // 提供present的时候使用到的动画执行对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        fadeAnimator.isPresenting = true
        return fadeAnimator
    }
}
