//
//  HTChangePresentToPushTransitionsAnimateManger.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/21.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTChangePresentToPushTransitionsAnimateManger.h"

@implementation HTChangePresentToPushTransitionsAnimateManger

//返回动画事件
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}


//所有的过渡动画事务都在这个方法里面完成
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.isPush) {
        [self pushAnimation:transitionContext];
    }else {
        [self popAnimation:transitionContext];
    }
}



- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];


    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    UIView *containerView = [transitionContext containerView];


    // 遍历图
    toView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
    [containerView addSubview:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                        // 移动到目标位置
                        toView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
                     }
                     completion:^(BOOL finished) {
//                         toVC.tempLabel.hidden = false;
//                         lableScreenShoot.hidden = true;
//                        // 动画完成移除
//                        [lableScreenShoot removeFromSuperview];
                        [transitionContext completeTransition:YES];
        }];
}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    toVC.tempLabel.hidden = true;

    //取出转场前后视图控制器上的视图view
      UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
      UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

      UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView addSubview:fromView];

    toView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                                // 移动到目标位置
         fromView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);

    } completion:^(BOOL finished) {
//                         //由于加入了手势交互转场，所以需要根据手势动作是否完成/取消来做操作
//                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                         if([transitionContext transitionWasCancelled]){
//                             //手势取消
//                         }else{
//                             //手势完成
//                             [containerView addSubview:toView];
//                         }
//                         toView.hidden = NO;


//                toVC.tempLabel.hidden = false;
//                lableScreenShoot.hidden = true;
//
//               // 动画完成移除
//               [lableScreenShoot removeFromSuperview];
               [transitionContext completeTransition:YES];
         }];
}

@end
