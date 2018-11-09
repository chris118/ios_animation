//
//  PushTansitionDelegate.swift
//  ios-animation
//
//  Created by Chris on 2018/11/8.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class PushTansitionDelegate: NSObject, UINavigationControllerDelegate {
    private lazy var fadeAnimator = FadeAnimator()
    // 是否需要交互
    var interactive = false
    
    //返回一个不可交互的转场动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeAnimator
    }
    
    // 返回一个可以交互的转场动画
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if interactive == false {
            return nil
        }
        
        return fadeAnimator
    }
    

    func handlePan(recognizer: UIPanGestureRecognizer) {
        fadeAnimator.handlePan(recognizer: recognizer)
    }
}
