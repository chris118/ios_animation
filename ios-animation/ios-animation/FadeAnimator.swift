//
//  FadeAnimator.swift
//  ios-animation
//
//  Created by Chris on 2018/11/7.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class FadeAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    let durationAnimation = 1.0
    
    //  present/dismiss, push/pop
    var isPresenting = true
    // 是否需要交互
    var interactive = false
    
    // 指定转场动画持续的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationAnimation
    }
    
    // 实现转场动画的具体内容
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 得到容器视图
        let containerView = transitionContext.containerView
        // 目标视图
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        containerView.addSubview(toView)
        
        // 为目标视图的展现添加动画
        toView.alpha = 0.0
        UIView.animate(withDuration: durationAnimation,
                       animations: {
                        toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view!.superview!)
        var progress: CGFloat = abs(translation.x / 200.0)
        progress = min(max(progress, 0.01), 0.99)
        
        switch recognizer.state {
        case .changed:
            // 更新当前转场动画播放进度
            update(progress)
        case .cancelled:
            cancel()
        case .ended:
            finish()
        default:
            break
        }
    }
}
