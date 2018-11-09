//
//  ViewController.swift
//  ios-animation
//
//  Created by Chris on 2018/11/5.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var objectView: UIView!
    @IBOutlet weak var objectView2: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UIAnimation

    // 函数形式
    @IBAction func UIAnimation_functionMethod(_ sender: Any) {
        UIView.beginAnimations("Identifier", context: nil)
        UIView.setAnimationDuration(1)
        objectView.center.x = objectView.center.x + 100
        UIView.commitAnimations()
    }
    
    // 闭包
    @IBAction func UIAnimation_blockMethod(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.objectView.center.x = self.objectView.center.x - 100
        }
    }
    
    //Delay_Properties
    @IBAction func UIAnimation_Delay_Properties(_ sender: Any) {
        //.curveEaseIn, .autoreverse, .repeat
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn, .autoreverse, .repeat], animations: {
            self.objectView.center.x = self.objectView.center.x - 100
        }, completion: nil)
        
        //delay
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn, animations: {
            self.objectView2.center.x = self.objectView2.center.x - 100
        }, completion: nil)
    }
    
    // Opacity
    @IBAction func UIAnimation_Opacity(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.objectView.alpha = 0.2
        }
    }
    
    // Scale
    @IBAction func UIAnimation_Scale(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.objectView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveLinear, animations: {
            self.objectView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
    }
    
    // Translation
    @IBAction func UIAnimation_position(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.objectView.transform = CGAffineTransform(translationX: 200, y: 200)
        }
    }
    
    // Color
    @IBAction func UIAnimation_Color(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.objectView.backgroundColor = UIColor.brown
        }, completion: nil)
    }
    
    // Rotation
    @IBAction func UIAnimation_Rotation(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.objectView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: nil)
    }
    
    // Spring
    @IBAction func UIAnimation_Spring(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: .curveEaseIn, animations: {
            self.objectView.center.y = self.objectView.center.y + 100
        }, completion:nil)
    }
    
    // Spring
    @IBAction func UIAnimation_KeyFrames(_ sender: Any) {
        UIView.animateKeyframes(withDuration: 10, delay: 0, options: .calculationModeCubicPaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/5, animations: {
                self.objectView.backgroundColor = UIColor.red
            })
            UIView.addKeyframe(withRelativeStartTime: 1/5, relativeDuration: 1/5, animations: {
                self.objectView.backgroundColor = UIColor.green
            })
            UIView.addKeyframe(withRelativeStartTime: 2/5, relativeDuration: 1/5, animations: {
                self.objectView.backgroundColor = UIColor.yellow
            })
            UIView.addKeyframe(withRelativeStartTime: 3/5, relativeDuration: 1/5, animations: {
                self.objectView.backgroundColor = UIColor.purple
            })
            UIView.addKeyframe(withRelativeStartTime: 4/5, relativeDuration: 1/5, animations: {
                self.objectView.backgroundColor = UIColor.gray
            })
        }, completion: nil)
    }
    
    // Transition
    @IBAction func UIAnimation_Transition(_ sender: Any) {
        UIView.transition(with: self.objectView, duration: 1.0, options: .transitionFlipFromLeft, animations: {
            if self.objectView.backgroundColor == UIColor.gray {
                self.objectView.backgroundColor = UIColor.blue
            }else {
                self.objectView.backgroundColor = UIColor.gray
            }
        }, completion: nil)
    }
    
    //ImageView
    @IBAction func UIAnimation_ImageView(_ sender: Any) {
        let image = UIImage.animatedImageNamed("voice", duration: 2)
        self.imageView.image = image
    }
    
    // MARK: CoreAnimation
    @IBAction func CoreAnimation_Position(_ sender: Any) {
        let baseAnimation = CABasicAnimation(keyPath: "position.x")
        baseAnimation.fromValue = objectView.center.x
        baseAnimation.toValue = objectView.center.x + 100
        baseAnimation.duration = 1
        //逆行动画
        baseAnimation.autoreverses = true
        baseAnimation.repeatCount = MAXFLOAT
        
        //防止动画接收后回到初始状态
        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        objectView.layer.add(baseAnimation, forKey: "demo")
    }
    
    @IBAction func CoreAnimation_Scale(_ sender: Any) {
        let baseAnimation = CABasicAnimation(keyPath: "transform.scale")
        baseAnimation.fromValue = 0.5
        baseAnimation.toValue = 1
        baseAnimation.duration = 1
        //逆行动画
//        baseAnimation.autoreverses = true
        baseAnimation.repeatCount = MAXFLOAT
        
        //防止动画接收后回到初始状态
//        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        objectView.layer.add(baseAnimation, forKey: "demo")
    }
    
    @IBAction func CoreAnimation_Spring(_ sender: Any) {
        let springAnimation = CASpringAnimation(keyPath: "position.x")
        springAnimation.damping = 5
        springAnimation.stiffness = 100;
        springAnimation.mass = 1;
        springAnimation.initialVelocity = 0;
        springAnimation.fromValue = objectView.layer.position.x;
        springAnimation.toValue = objectView.layer.position.x + 50;
        springAnimation.duration = springAnimation.settlingDuration;
        objectView.layer.add(springAnimation, forKey: springAnimation.keyPath);
     }
    
    @IBAction func CoreAnimation_KeyframeAnimation_Shake(_ sender: Any) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        //设置晃动角度
        let angle = Double.pi / 2
        //设置关键帧动画的值
        shakeAnimation.values = [angle, -angle, angle]
        //设置关键帧动画每帧的执行时间，这里不设置也行，默认平均分配时间
        shakeAnimation.keyTimes = [0, 0.5, 1]
        //设置动画重复次数，默认为1次
        shakeAnimation.repeatCount = MAXFLOAT
        //设置动画执行效果
        shakeAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)]
        //设置相邻动画过渡方式
        shakeAnimation.calculationMode = CAAnimationCalculationMode.cubic
        objectView.layer.add(shakeAnimation, forKey: shakeAnimation.keyPath);

    }
    
    @IBAction func CoreAnimation_KeyframeAnimation_Path(_ sender: Any) {
        let path = UIBezierPath()
        //设置动画的执行路径为一个M的形状
        path.move(to: CGPoint(x: 40, y: 300))
        path.addLine(to: CGPoint(x: 80, y: 150))
        path.addLine(to: CGPoint(x: 120, y: 300))
        path.addLine(to: CGPoint(x: 160, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 300))
        let bezierAnimation = CAKeyframeAnimation(keyPath: "position")
        //由于CAKeyframeAnimation的path为CGPath，所以这里要转换一次
        bezierAnimation.path = path.cgPath
        //设置动画时间
        bezierAnimation.duration = 4
        //自动旋转layer角度与path相切
        bezierAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
        //设置动画重复次数
        bezierAnimation.repeatCount = MAXFLOAT
        //设置自动逆向
        bezierAnimation.autoreverses = true
        objectView.layer.add(bezierAnimation, forKey: nil)
    }
    
    @IBAction func CoreAnimation_KeyframeAnimation_Scale(_ sender: Any) {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [0.2, 0.4, 0.8, 1.2, 1.6, 1.2, 0.8, 0.4, 0.2]
        scaleAnimation.duration = 1
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = MAXFLOAT
        objectView.layer.add(scaleAnimation, forKey: nil)
    }
    
    @IBAction func CoreAnimation_AnimationGroup(_ sender: Any) {
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x:20,y:100))
        path.addQuadCurve(to: CGPoint.init(x: 300, y: 300), controlPoint: CGPoint.init(x: 150, y: 20))
        
        //获取贝塞尔曲线的路径
        let animationPath = CAKeyframeAnimation.init(keyPath: "position")
        animationPath.path = path.cgPath
        animationPath.rotationMode = CAAnimationRotationMode.rotateAuto
        
        //旋转
        let rotate:CABasicAnimation = CABasicAnimation()
        rotate.keyPath = "transform.rotation"
        rotate.toValue = Double.pi
        
        //缩小图片到0
        let scale:CABasicAnimation = CABasicAnimation()
        scale.keyPath = "transform.scale"
        scale.toValue = 0.0
        
        //组合动画
        let animationGroup:CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [animationPath,rotate,scale];
        animationGroup.duration = 2.0;
        animationGroup.fillMode = CAMediaTimingFillMode.forwards;
        animationGroup.isRemovedOnCompletion = true
        objectView.layer.add(animationGroup, forKey:
            nil)
    }
    
    @IBAction func CoreAnimation_CATransition(_ sender: Any) {
        let animation = CATransition()
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        // `fade', `moveIn', `push' and `reveal'. Defaults to `fade'
        animation.type = CATransitionType.reveal
        // `fromLeft', `fromRight', `fromTop' and `fromBottom'
        animation.subtype = CATransitionSubtype.fromLeft
//        animation.isRemovedOnCompletion = true
        animation.startProgress = 0.5
        objectView.layer.add(animation, forKey: nil)
    }
    
    @IBAction func CoreAnimation_CATransition_ViewController(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "second")
        
        let anima = CATransition.init()
//        anima.type = CATransitionType.reveal
        anima.type = CATransitionType(rawValue: "pageUnCurl")
        anima.subtype = CATransitionSubtype.fromLeft
        anima.duration = 1.0
        
        // 添加转场动画到导航视图控制上
//        UIApplication.shared.keyWindow?.layer.add(anima, forKey: "pageUnCurl")
        self.navigationController?.view.layer.add(anima, forKey: "pageUnCurl")
//        UIApplication.shared.keyWindow?.layer.removeAnimation(forKey: "pageUnCurl")
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: Other Animation
    let transitionDelegate = FadeTransitionDelegate()
    @IBAction func UIViewControllerAnimatedTransitioning_Model(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "second")
        
        vc.transitioningDelegate = transitionDelegate
        present(vc, animated: true, completion: nil)
    }

    let pushTransitionDelegate = PushTansitionDelegate()
    @IBAction func UIViewControllerAnimatedTransitioning_Push(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "second")
        
        self.navigationController?.delegate = pushTransitionDelegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var animator: UIDynamicAnimator!
    @IBAction func UIDynamic_tap(_ sender: Any) {
        animator = UIDynamicAnimator(referenceView: self.view)
        let behavior = UIGravityBehavior(items: [objectView])
        animator.addBehavior(behavior)
        
        let behaviorCollision = UICollisionBehavior(items: [objectView])
        behaviorCollision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(behaviorCollision)
    }
    
    var rainLayer: CAEmitterLayer!
    @IBAction func CAEmitterLayer_tap(_ sender: Any) {
        // 粒子发射图层
        rainLayer = CAEmitterLayer()
        // 发射器形状为线形，默认发射方向向上
        rainLayer.emitterShape = CAEmitterLayerEmitterShape.line
        // 从发射器的轮廓发射粒子
        rainLayer.emitterMode = CAEmitterLayerEmitterMode.outline
        // 优先渲染旧的粒子
        rainLayer.renderMode = CAEmitterLayerRenderMode.oldestFirst
        // 发射位置
        // 对于线形发射器，线的两端点分别为
        // (emitterPosition.x - emitterSize.width/2, emitterPosition.y, emitterZPosition)和
        // (emitterPosition.x + emitterSize.width/2, emitterPosition.y, emitterZPosition)
        rainLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 0)
        // 发射器大小
        rainLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        // 粒子生成速率的倍数，一开始不发射，设置为零
        rainLayer.birthRate = 0
        
        // 发射的粒子
        let cell = CAEmitterCell()
        // 粒子显示的内容，设置CGImage，显示图片
        cell.contents = UIImage(named: "star")?.cgImage
        // 粒子缩放倍数
        cell.scale = 0.1
        // 粒子寿命，单位是秒
        cell.lifetime = 5
        // 粒子生成速率，单位是个/秒，实际显示效果要乘以CAEmitterLayer的birthRate
        cell.birthRate = 1000
        // 粒子速度
        cell.velocity = 500
        // 粒子发射角度，正值表示顺时针方向
        cell.emissionLongitude = CGFloat.pi
        
        // 图层要发射1种粒子
        rainLayer.emitterCells = [cell]
        // 添加粒子发射图层
        view.layer.addSublayer(rainLayer)
        
        
        
        //  粒子生成速率渐变动画
        let birthRateAnimation = CABasicAnimation(keyPath: "birthRate")
        birthRateAnimation.duration = 3
        if rainLayer.birthRate == 0 {
            // 雨变大
            birthRateAnimation.fromValue = 0
            birthRateAnimation.toValue = 1
            rainLayer.birthRate = 1
        } else {
            // 雨变小
            birthRateAnimation.fromValue = 1
            birthRateAnimation.toValue = 0
            rainLayer.birthRate = 0
        }
        // 加入动画
        rainLayer.add(birthRateAnimation, forKey: "birthRate")
    }
}




