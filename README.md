# iOS 动画

在iOS实际开发中常用的动画总结下来包含四种：
> * UIViewAnimation动画
> * CoreAnimation核心动画
> * 其他动画
> 
-------------------

[TOC]

##1 UIViewAnimation动画

UIView的两种动画api包含 **方法形式** 和 **block** 形式, 其中包含三种动画实现

* UIView(UIViewAnimation)
* UIView (UIViewKeyframeAnimations)
* UIViewControllerAnimatedTransitioning

**可设置动画属性**
> * frame //大小变化：改变视图框架（frame）和边界。
> * bounds //拉伸变化：改变视图内容的延展区域。
> * center //居中显示
> * transform //旋转：即任何应用到视图上的仿射变换（transform）
> * alpha //改变透明度：改变视图的alpha值。
> * backgroundColor //改变背景颜色
> * contentStretch //拉伸内容

**参数**
> * duration //为动画持续的时间。
> * animations //为动画效果的代码块。
> * completion //为动画执行完毕以后执行的代码块
> * options //为动画执行的选项
> * delay //为动画开始执行前等待的时间

**方法形式**

```
UIView(UIViewAnimation);
 设置动画ID 方便查询
 + (void)beginAnimations:(nullable NSString *)animationID context:(nullable void *)context;
 提交动画 执行动画
 + (void)commitAnimations;
 设置动画执行时间
 + (void)setAnimationDuration:(NSTimeInterval)duration;
 设置动画执延迟执行时间
 + (void)setAnimationDelay:(NSTimeInterval)delay;
 设置动画代理对象，当动画开始或者结束时会发消息给代理对象
 + (void)setAnimationDelegate:(nullable id)delegate;
 设置动画开始时调用的方法 执行delegate对象的selector，并且把beginAnimations:context:中传入的参数传进selector
 + (void)setAnimationWillStartSelector:(nullable SEL)selector;
 设置动画结束时调用的方法 执行delegate对象的selector，并且把beginAnimations:context:中传入的参数传进selector
 + (void)setAnimationDidStopSelector:(nullable SEL)selector;
 设置动画的开始时间，默认为now
 + (void)setAnimationStartDate:(NSDate *)startDate
 设置视图view的过渡效果, transition指定过渡类型, cache设置YES代表使用视图缓存，性能较好
 + (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache
 设置是否自动恢复执行 YES,代表动画每次重复执行的效果会跟上一次相反
 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses
 设置动画的重复次数
 + (void)setAnimationRepeatCount:(float)repeatCount
 设置动画执行效果
 + (void)setAnimationCurve:(UIViewAnimationCurve)curve
 设置动画是否生效
 + (void)setAnimationsEnabled:(BOOL)enabled;

```

**block 形式**
将动画实现封装在block区域，参数构建在类方法上。

```
可选动画执行效果，如进出效果等
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

带回调block动画，动画执行完成后进入block
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0

不带回调动画
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0, completion = NULL

弹簧动画
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

view的转场动画
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

view到另一个view的转场动画
+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // toView added to fromView.superview, fromView removed from its superview

+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray<__kindof UIView *> *)views options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))parallelAnimations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
```

###1 UIView(UIViewAnimation)