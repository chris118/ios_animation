 iOS 动画

[Git代码地址](https://github.com/chris118/ios_animation)

![enter image description here](https://img-blog.csdn.net/20180110164229222?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTWF6eV9tYQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

在iOS实际开发中常用的动画总结下来包含3种：
> * UIViewAnimation动画
> * CoreAnimation核心动画
> * 其他动画

-------------------

[TOC]

##UIViewAnimation动画
UIView的两种动画api包含 **方法形式** 和 **block** 形式, 其中包含三种动画实现

* UIView(UIViewAnimation)
* UIView (UIViewKeyframeAnimation)
* UIViewControllerAnimatedTransitioning

###**函数形式**

```
// 开始动画
UIView.beginAnimations("Identifier", context: nil)
//  设置动画代理
UIView.setAnimationDelegate(self)
// 通过 #selector 选择器 添加开始动画方法
UIView.setAnimationWillStart(#selector(animationAction))
// 通过 #selector 选择器 添加结束动画方法
UIView.setAnimationDidStop(#selector(animationAction))
// 设置动画时间间隔
UIView.setAnimationDuration(1.0)
// 设置动画延迟
UIView.setAnimationDelay(0)
// 设置动画开始的时间，默认是现在开始
UIView.setAnimationStart(Date())
// 设置动画曲线
UIView.setAnimationCurve(.easeInOut)
// 设置动画重复次数，默认是 0
UIView.setAnimationRepeatCount(0) // 0 无线循环
// 自动返回原始状态
UIView.setAnimationRepeatAutoreverses(false) // default = NO. used if repeat count is non-zero
// 设置动画的开始是从现在的状态开始, 默认是 false
UIView.setAnimationBeginsFromCurrentState(false)
// 用来开启或禁止动画显示
UIView.setAnimationsEnabled(true)
// 设置动画的过渡效果
UIView.setAnimationTransition(.curlUp, for: redView, cache: false)

// 设置 UIView 的动画属性
redView.transform = CGAffineTransform(rotationAngle: 90)
redView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
redView.transform = CGAffineTransform(translationX: 0, y: 200)

// 动画的状态
print(UIView.areAnimationsEnabled)
// 标志动画代码结束，程序会创建新的线程，并准备运行动画
UIView.commitAnimations()
```
```
UIView.beginAnimations("Identifier", context: nil)
UIView.setAnimationDuration(1)
objectView.center.x = objectView.center.x + 100
UIView.commitAnimations()
```
###**block形式**
将动画实现封装在block区域，参数构建在类方法上。

```
UIView.animate(withDuration: TimeInterval,
                 animations: ()->Void)

UIView.animate(withDuration: TimeInterval,
                 animations: ()->Void,
                 completion: ()->Void)

// 带动画曲线动画
UIView.animate(withDuration: TimeInterval,
                      delay: TimeInterval,
                    options: UIViewAnimationOptions,
                 animations: ()->Void,
                 completion: (()->Void)?)

// 带弹性动画
UIView.animate(withDuration: TimeInterval,
                      delay: TimeInterval,
     usingSpringWithDamping: 0,
      initialSpringVelocity: 0,
                    options: UIViewAnimationOptions,
                 animations: ()->Void,
                 completion: (()->Void)?)
```
```
UIView.animate(withDuration: 1.0) {
    self.objectView.center.x = self.objectView.center.x - 100
}
``` 
### 更多参数动画函数
```
//.curveEaseIn, .autoreverse, .repeat
 UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn, .autoreverse, .repeat], animations: {
     self.objectView.center.x = self.objectView.center.x - 100
 }, completion: nil)
 
 //delay
 UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn, animations: {
     self.objectView2.center.x = self.objectView2.center.x - 100
 }, completion: nil)
```
**各个参数的含义**
```
Duration  ：动画执行的时长
delay     ：延时时长，即上一个动画执行完以后多久再执行下一个动画
options   ：一些样式的选取
animations：我们想要实现的动画效果
completion：动画执行完我们还想做的事情
```
**options**

1.属性设置
```
UIViewAnimationOptionLayoutSubviews // 动画过程中保证子视图跟随运动 
UIViewAnimationOptionAllowUserInteraction   // 动画过程中允许用户交互  
UIViewAnimationOptionBeginFromCurrentState    // 所有视图从当前状态开始运行
UIViewAnimationOptionRepeat  // 重复运行动画                
UIViewAnimationOptionAutoreverse  // 动画运行到结束点后仍然以动画方式回到初始点       
UIViewAnimationOptionOverrideInheritedDuration // 忽略嵌套动画时间设置
UIViewAnimationOptionOverrideInheritedCurve   // 忽略嵌套动画速度设置 
UIViewAnimationOptionAllowAnimatedContent  // 动画过程中重绘视图（注意仅仅适用于转场动画）    
UIViewAnimationOptionShowHideTransitionViews // 视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）  
UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置或动画类型
```
2.动画速度控制
```
UIViewAnimationOptionCurveEaseInOut   // 动画先缓慢，然后逐渐加速
UIViewAnimationOptionCurveEaseIn    // 动画逐渐变慢        
UIViewAnimationOptionCurveEaseOut   // 动画逐渐加速       
UIViewAnimationOptionCurveLinear    // 动画匀速执行，默认值
```
3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
```
UIViewAnimationOptionTransitionNone  // 没有转场动画效果        
UIViewAnimationOptionTransitionFlipFromLeft  // 从左侧翻转效果 
UIViewAnimationOptionTransitionFlipFromRight  // 从右侧翻转效果
UIViewAnimationOptionTransitionCurlUp // 向后翻页的动画过渡效果        
UIViewAnimationOptionTransitionCurlDown  // 向前翻页的动画过渡效果      
UIViewAnimationOptionTransitionCrossDissolve  // 旧视图溶解消失显示下一个新视图的效果 
UIViewAnimationOptionTransitionFlipFromTop  // 从上方翻转效果   
UIViewAnimationOptionTransitionFlipFromBottom // 从底部翻转效果
```
支持的动画属性
```
frame //大小变化：改变视图框架（frame）和边界。
bounds //拉伸变化：改变视图内容的延展区域。
center //居中显示
transform //仿射变换（transform）
alpha //改变透明度：改变视图的alpha值。
backgroundColor //改变背景颜色
contentStretch //拉伸内容
```

- Opacity -- 设置透明度
```
UIView.animate(withDuration: 1.0) {
    self.objectView.alpha = 0.2
}
```
- Scale -- 放大缩小
```
UIView.animate(withDuration: 1.0) {
    self.objectView.transform = CGAffineTransform(scaleX: 2, y: 2)
}

UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveLinear, animations: {
    self.objectView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
}, completion: nil)
```
- Translation -- 平移
```
UIView.animate(withDuration: 1.0) {
    self.objectView.transform = CGAffineTransform(translationX: 200, y: 200)
}
```
- Color -- 颜色
```
UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
    self.objectView.backgroundColor = UIColor.brown
}, completion: nil)
```
- Rotation -- 旋转
```
UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear, .repeat], animations: {
    self.objectView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
}, completion: nil)
```

###弹簧动画函数
```
UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: .curveEaseIn, animations: {
    self.objectView.center.y = self.objectView.center.y + 100
}, completion:nil)
```
### 关键帧动画
为当前视图建立可以容纳一个或多个关键帧动画对象的动画块，然后根据指定的时间一帧帧的执行指定动画，需要与addKeyframeWithRelativeStartTime: relativeDuration: animations: 结合使用，注意：如果在block中没用添加关键帧动画对象，动画还是会执行，只不过跟调用animateWithDuration(duration: delay: options: animations: completion: 效果一样！简单点来说，调用该API就是创建了一个动画容器，然后可以向这个容器中添加多个动画！

UIViewKeyframeAnimationOptions：
```
1 .CalculationModeLinear：在帧动画之间采用线性过渡
2 .CalculationModeDiscrete：在帧动画之间不过渡，直接执行各自动画
3 .CalculationModePaced：将不同帧动画的效果尽量融合为一个比较流畅的动画
4 .CalculationModeCubic：不同帧动画之间采用Catmull-Rom算法过渡
5 .CalculationModeCubicPaced：3和4结合，试了就知道什么效果了
```
animateKeyframesWithDuration:delay:options:animations:completion:结合使用，用来指定帧动画开始时间，持续时间和执行操作，调用一次就可以添加一个帧动画！
```
frameStartTime:帧动画开始时间，取值范围为(0,1)，开始时间是相对于整个动画时间，整个关键帧动画时长6秒，设置开始时间为0.5，那么这一帧动画的实际开始时间为第3秒！
2 frameDuration：帧动画持续时间，取值范围为(0,1)，持续时间也是相对于整个动画时间，算法同上！
```
```
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
```
### Transitions 过渡
过度动画强调的是view改变内容。一般有两个方法
```
UIView.transition(with:, duration:, options:, animations:, completion:)
UIView.transition(from: , to:, duration:, options:, completion:)
```
过渡动画的类型是一个options （UIViewAnimationOptions）
```
.transitionFlipFromLeft,.transitionFlipFromRight
.transitionFlipFromTop,.transitionFlipFromBottom
.transitionCurlUp,.transitionCurlDown
.transitionCrossDissolve
```
```
if self.objectView.backgroundColor == UIColor.gray {
    self.objectView.backgroundColor = UIColor.blue
}else {
    self.objectView.backgroundColor = UIColor.gray
}
}, completion: nil)
```
### ImageView动画
在 UIImageView 上执行动画非常简单，只需要提供animationImages 属性。一个UIImage 数组。这个数组代码一个一个的帧，当我们调用 startAnimating 方法的时候，这个数组的图片就会轮流播放。animationDuration 决定了播放的速度。animationRepeatCount指定重复次数 （默认是0 ， 代表无限重复），或者调用stopAnimating 方法停止动画。

UIImage 有一些类方法为 UIImageView 构造 可以动画的image :

直接指定了image数组和duration。
```
UIImage.animatedImage(with:, duration:)
```
提供一个单个的image name ， 系统会自动在后面加 "0" (如果失败则"1") 。使这个image成为第一个image。最后一位数字累加。（知道没有图片或者到达”1024“）
```
UIImage.animatedImageNamed(, duration: )
```
跟上面的方式差不多，但是同时对每个image做了拉伸或者平铺。 图像本身也有resizableImage(withCapInsets: , resizingMode: )方法可以缩放（指定某个区域的拉伸或者平铺）
```
UIImage.animatedResizableImageNamed(, capInsets: , duration: )
```

```
let image = UIImage.animatedImageNamed("voice", duration: 2)
self.imageView.image = image
```
其中voice1-3 已经命名好，放在Assets.xcassets

##CoreAnimation核心动画
Core Animation可以用在 Mac OS X 和 iOS平台. Core Animation的动画执行过程是在后台操作的.不会阻塞主线程. 要注意的是, Core Animation是直接作用在CALayer上的.并非UIView

- CABasicAnimation 基础动画
- CAKeyframeAnimation 关键帧动画
- CATransition 转场动画
- CAAnimationGroup 组动画
- CASpringAnimation 弹性动画 （iOS9.0之后新增CASpringAnimation类，它实现弹簧效果的动画，是CABasicAnimation的子类。）

动画操作过程：
- 创建一个CAAnimation对象
- 设置一些动画的相关属性
- 给CALayer添加动画（addAnimation:forKey: 方法）
- 移除CALayer中得动画（removeAnimationForKey: 方法）

###CAAnimation （一部分属性来自 CAMediaTiming）

![enter image description here](http://cc.cocimg.com/api/uploads/20170622/1498114752750475.png)

1. duration：动画的持续时间，默认为0.25秒
2. speed ：速度 speed = 1.0 / duration = 1.0 的动画效果 和 speed = 2.0 / duration = 2.0 的动画效果是一模一样的，我们设置的duration可能和动画进行的真实duration不一样，这个还依赖于speed。

3. timeOffset 设置动画线的起始结束时间点
```
//假定一个3s的动画，它的状态为t0,t1,t2,t3，当没有timeOffset的时候，正常的状态序列应该为：
//t0->t1->t2->t3
//当设置timeOffset为1的时候状态序列就变为
//t1->t2->t3->t0
//同理当timeOffset为2的时候状态序列就变为：
//t2->t3->t0->t1
```
4. autoreverses：是否自动回到动画开始状态

5. repeatCount：动画的重复次数

6. repeatDuration：动画的重复时间

7. removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode属性为kCAFillModeForwards

8. fillMode：决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后

9. beginTime：可以用来设置动画延迟执行时间，若想延迟2s，就设置为CACurrentMediaTime()+2，CACurrentMediaTime()为图层的当前时间。 CALayer 的beginTime 一般用于动画暂停的使用,CAAnimation 的beginTime一般用于动画延迟执行，但只在使用groupAnimation的时候生效，直接添加在layer上的animation使用会导致动画不执行。

10. timingFunction：速度控制函数，控制动画运行的节奏

枚举参数：
```
kCAMediaTimingFunctionLinear  时间曲线函数，匀速
kCAMediaTimingFunctionEaseIn  时间曲线函数，由慢到特别快
kCAMediaTimingFunctionEaseOut  时间曲线函数，由快到慢
kCAMediaTimingFunctionEaseInEaseOut  时间曲线函数，由慢到快
kCAMediaTimingFunctionDefault   系统默认
```
11. delegate：动画代理，一般设置隐式代理，该代理是NSObject的分类，需要遵守协议CAAnimationDelegate
```
-(void)animationDidStart:(CAAnimation *)anim; 核心动画开始时执行

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag; 核心动画执行结束后调用
```
### CAPropertyAnimation
属性：

**keyPath**：通过指定CALayer的一个属性名做为keyPath里的参数(NSString类型)，并且对CALayer的这个属性的值进行修改，达到相应的动画效果。比如，指定@”position”为keyPath，就修改CALayer的position属性的值，以达到平移的动画效果。
```
CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
```
一些常用的**animationWithKeyPath**值的总结
| 值      |    说明	 | 使用形式  |
| :-------- | --------:| :--: |
| transform.scale	|比例转化|	@(0.8)|
| transform.scale.x	|宽的比例|	@(0.8)|
| transform.scale.y	|高的比例	|@(0.8)|
| transform.rotation.x	|围绕x轴旋转	|@(M_PI)|
| transform.rotation.y	|围绕y轴旋转	|@(M_PI)|
| transform.rotation.z	|围绕z轴旋转	|@(M_PI)|
| cornerRadius	|圆角的设置	|@(50)|
| backgroundColor	|背景颜色的变化|	(id)[UIColor purpleColor].CGColor|
| bounds	|大小，中心不变|	[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];|
| position	|位置(中心点的改变)|	[NSValue valueWithCGPoint:CGPointMake(300, 300)];|
| contents	|内容，比如UIImageView的图片|	imageAnima.toValue = (id)[UIImage | imageNamed:@"to"].CGImage;|
| opacity	|透明度|	@(0.7)|
| contentsRect.size.width	|横向拉伸缩放|	@(0.4)最好是0~1之间的|

####CABasicAnimation基本动画
CABasicAnimation能实现诸多的动画,移动,旋转,缩放....KeyPath所涉及的都能实现

**1.fromValue** : keyPath相应属性的初始值
**2.toValue **: keyPath相应属性的结束值，到某个固定的值（类似transform的make含义）
注意：随着动画的进行,在长度为duration的持续时间内,keyPath相应属性的值从fromValue渐渐地变为toValue.
如果fillMode = kCAFillModeForwards和removedOnComletion = NO;那么在动画执行完毕后,图层会保持显示动画执行后的状态,但实质上,图层的属性值还是动画执行前的初始值,并没有真正被改变.比如: CALayer的postion初始值为(0,0),CABasicAnimation的fromValue为(10,10),toValue为 (100,100),虽然动画执行完毕后图层保持在(100,100) 这个位置,实质上图层的position还是为(0,0);
**3.byValue**：不断进行累加的数值（byvalue 值加上fromValue => tovalue）

Position
```
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
```

Scale
```
let baseAnimation = CABasicAnimation(keyPath: "transform.scale")
baseAnimation.fromValue = 0.5
baseAnimation.toValue = 1
baseAnimation.duration = 1
baseAnimation.repeatCount = MAXFLOAT
baseAnimation.fillMode = CAMediaTimingFillMode.forwards
objectView.layer.add(baseAnimation, forKey: "demo")
```

####CASpringAnimation弹性动画
iOS9才引入的动画类，它继承于CABaseAnimation，用于制作弹簧动画

参数说明:

mass:
质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大

stiffness:
刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快

damping:
阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快

initialVelocity:
初始速率，动画视图的初始速度大小
速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反

settlingDuration:
结算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算
通常弹簧动画的时间使用结算时间比较准确

```
let springAnimation = CASpringAnimation(keyPath: "position.x")
springAnimation.damping = 5
springAnimation.stiffness = 100;
springAnimation.mass = 1;
springAnimation.initialVelocity = 0;
springAnimation.fromValue = objectView.layer.position.x;
springAnimation.toValue = objectView.layer.position.x + 50;
springAnimation.duration = springAnimation.settlingDuration;
objectView.layer.add(springAnimation, forKey: springAnimation.keyPath);
```


####CAKeyframeAnimation关键帧动画
- CAKeyframeAnimation跟CABasicAnimation的区别是:
CABasicAnimation只能从一个数值(fromValue)变到另一个数值(toValue)，而CAKeyframeAnimation会使用一个NSArray保存这些数值.
- CAKeyframeAnimation属性解析:
values:就是上述的NSArray对象。里面的元素称为”关键帧”(keyframe)。动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧 .
path:如果你设置了path，那么values将被忽略.
keyTimes:可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的.
注: CABasicAnimation能实现的CAKeyframeAnimation也能实现,而且更具体和准确

**Shake Sample**
```
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
```

**轨迹动画**
```
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
```
**Scale动画**
```
let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
scaleAnimation.values = [0.0, 0.4, 0.8, 1.2, 1.6, 1.2, 0.8, 0.4, 0.0]
scaleAnimation.duration = 2
scaleAnimation.autoreverses = true
scaleAnimation.repeatCount = MAXFLOAT
objectView.layer.add(scaleAnimation, forKey: nil)
```

###CAAnimationGroup组合动画
将多个动画组合和并发运行 
delegate 和 isRemovedOnCompletion 在动画的属性数组中目前被忽略。 
CAAnimationGroup 的 delegate 接收这些消息
- animations CAAnimation 数组，用于添加多个 CAAnimation 动画
```
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
animationGroup.isRemovedOnCompletion = false
objectView.layer.add(animationGroup, forKey:
    nil)
```

###CATransition转场动画
>CAAnimation的子类 
在图层状态之间提供动画转换的对象 
提供了一个图层之间的过渡的动画

CATransition 有一个 type 和 subtype 来标识变换效果

**新增加的属性**
- startProgress 开始的进度 0~1
- endProgress 结束时的进度 0~1
- type 转换类型 
	- kCATransitionFade (default)
	- kCATransitionMoveIn
	- kCATransitionPush
	- kCATransitionReveal
- API引入的type，在苹果官网是不会承认的，所以不建议使用
    - 1 animation.type = @"cube"; //立方体效果
    - 2 animation.type = @"suckEffect";//犹如一块布被抽走
    - 3 animation.type = @"oglFlip"; //上下翻转效果
    - 4 animation.type = @"rippleEffect"; //滴水效果
    - 5 animation.type = @"pageCurl"; //向左翻页
    - 6 animation.type = @"pageUnCurl"; //向下翻页
- subtype 基于运动方向预定义的转换 
	- kCATransitionFromLeft
	- kCATransitionFromRight
	- kCATransitionFromTop
	- kCATransitionFromBottom
- filter 滤镜

** View Transaition**
```
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
```

** ViewController Transaition(翻页效果)**

```
let vc = UIStoryboard(name: "Main", bundle: nil)
    .instantiateViewController(withIdentifier: "second")

let anima = CATransition.init()
//        anima.type = CATransitionType.reveal
anima.type = CATransitionType(rawValue: "pageUnCurl")
anima.subtype = CATransitionSubtype.fromLeft
anima.duration = 1.0

UIApplication.shared.keyWindow?.layer.add(anima, forKey: "pageUnCurl")
//        UIApplication.shared.keyWindow?.layer.removeAnimation(forKey: "pageUnCurl")
self.navigationController?.pushViewController(vc, animated: false)
```


##其他动画

###控制器转场动画 UIViewControllerAnimatedTransitioning

####一、 转场动画-modal
给vc的transitioningDelegate属性赋值，为即将跳转的vc指定转场动画代理，协议中有两个基础方法，分别要求代理返回present时的动画以及dismiss时的动画。
```
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
```
写一个类专门来实现UIViewControllerAnimatedTransitioning动画协议，作为动画的实现类。然后代理就可以返回两个动画实现对象，实现UIViewControllerTransitioningDelegate转场代理协议。

获取转场过程的三个视图：containerView、fromView、toView。
containerView是动画过程中提供的暂时容器。
fromView是转场开始页的视图。
toView是转场结束页的视图。

转场的过程，大多数情况下我们都是对toView作各种变换操作，例如改变toView的alpha，size，旋转等等。 在对它进行操作前，需要先把它放到container上才能显示出来。[container addSubview:toView];
```
class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var isPresenting = true
    
    // 指定转场动画持续的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
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
        UIView.animate(withDuration: duration,
                       animations: {
                        toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
```
最后presentViewController的时候赋值代理
```
let transitionDelegate = FadeTransitionDelegate()
 @IBAction func UIViewControllerAnimatedTransitioning_Demo(_ sender: Any) {
     let vc = UIStoryboard(name: "Main", bundle: nil)
         .instantiateViewController(withIdentifier: "second")
     
     vc.transitioningDelegate = transitionDelegate
     present(vc, animated: true, completion: nil)
 }
```

####二、 转场动画-push
流程同 **转场动画基础用法-modal**
要自定义push动画，需实现导航控制器的代理协议 UINavigationControllerDelegate
```
class PushTansitionDelegate: NSObject, UINavigationControllerDelegate {
    private lazy var fadeAnimator = FadeAnimator()
    // 是否需要交互
    var interactive = false
    
    //返回一个不可交互的转场动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeAnimator
    }
}
```
其中fadeAnimator和Model里的是同样的定义。
使用Push动画
```
let vc = UIStoryboard(name: "Main", bundle: nil)
    .instantiateViewController(withIdentifier: "second")

self.navigationController?.delegate = pushTransitionDelegate
self.navigationController?.pushViewController(vc, animated: true)
```

####一、 转场动画-交互式转场动画
交互式过渡是由事件驱动的。可以是动作事件或者手势，通常为手势。要实现一个交互式过渡，除了需要跟之前相同的动画，还需要告诉交互控制器动画完成了多少。开发者只需要确定已经完成的百分比，其他交给系统去做就可以了。例如，（平移和缩放的距离 / 速度的量可以作为计算完成的百分比的参数）。

交互式控制器实现了 UIViewControllerInteractiveTransitioning 协议：
```
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
```
这个方法里只能有一个动画块，动画应该基于 UIView 而不是图层，交互式过渡不支持 CATransition 或 CALayer 动画。

交互式过渡的交互控制器应当是 UIPercentDrivenInteractiveTransition 子类。动画类负责计算完成百分比，系统会自动更新动画的中间状态。
```
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;
```

对FadeAnimator添加handlePan，并且继承**UIPercentDrivenInteractiveTransition** 支持交互式动画
```
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
```
对应的Delegate更改为 支持交互的转场动画：
```
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
```

控制器中使用，第二个页面返回的时候使用交互式转场动画
```
class SecondViewController: UIViewController {
     let pushTransitionDelegate = PushTansitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        self.view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            
            pushTransitionDelegate.interactive = true
            self.navigationController?.delegate = pushTransitionDelegate
            self.navigationController?.popViewController(animated: true)
        }else {
            pushTransitionDelegate.handlePan(recognizer: recognizer)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
```

###UIDynamic-动力学框架
UIDynamic是苹果在iOS7之后添加的一套动力学框架，运用它我们可以极其方便地模拟现实生活中的运动，比如重力，碰撞等等。它是通过添加行为的方式让动力学元素参与运动的。

iOS7.0中提供的动力学行为包括：

UIGravityBehavior：重力行为
UICollisionBehavior：碰撞行为
UIAttachmentBehavior：附着行为
UISnapBehavior：吸附行为
UIPushBehavior：推行为
UIDynamicItemBehavior：动力学元素行为

UIDynamic的使用还是相对简单

1.首先我们创建一个小方块 objectView 并把它放在self.view的上面部分。（只有遵循了UIDynamicItem协议的对象才能参与仿真模拟，而UIView正遵循了此协议，因此所有视图控件都能参与仿真运动）

2.然后定义一个 UIDynamicAnimator 物理仿真器（凡是要参与运动的对象必须添加到此容器中）

3.再添加一个重力行为 到仿真器,并且 这个行为作用对象是我们之前定义的boxView

4.可以发现 放在self.view上半部分的boxView受重力行为影响，往下掉落。但是会掉出self.view范围。

5.为了不掉出self.view 范围 我们还需要给objectView添加一个别的行为：碰撞行为，接触到仿真器边界或者其他self.view中得容器会产生碰撞效果。

6.这样小方块就不会掉出仿真器范围了，同理，其他行为的使用方式和上面一样，一定要添加到仿真器才能生效。

```
var animator: UIDynamicAnimator!
@IBAction func UIDynamic_tap(_ sender: Any) {
    animator = UIDynamicAnimator(referenceView: self.view)
    let behavior = UIGravityBehavior(items: [objectView])
    animator.addBehavior(behavior)
    
    let behaviorCollision = UICollisionBehavior(items: [objectView])
    behaviorCollision.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(behaviorCollision)
}
```
### CAEmitterLayer 粒子动画
1、CAEmitterLayer。 这个主要是定义粒子原型发射层的形状和发射位置，发射源的尺寸以及发射的模式等。

2、CAEmitterCell 单个粒子的原型，通常有多个，根据cell的属性和CAEmitterCell的配置，由uikit随机生成，粒子原型的属性包括粒子的图片，颜色，方向，运动，缩放比例和生命周期等。

这两个类的参数看起来似乎很简单，但这些参数的不同组合配合上相对应图片，则可以实现许多意想不到的动画效果。

```
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
```
参考连接
https://www.jianshu.com/p/71f2fa270b9c
https://www.jianshu.com/p/9aead7675221
https://www.jianshu.com/p/802d47f0f311
