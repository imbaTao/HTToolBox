//
//  HTChangePresentToPushTransitionsVC.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/21.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTChangePresentToPushTransitionsVC.h"
#import "HTChangePresentToPushTransitionsAnimateManger.h"

@interface HTChangePresentToPushTransitionsVC ()<UINavigationControllerDelegate>

//动画过渡转场
@property (nonatomic, strong) HTChangePresentToPushTransitionsAnimateManger * transitionAnimation;

@end

@implementation HTChangePresentToPushTransitionsVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionAnimation = [[HTChangePresentToPushTransitionsAnimateManger alloc] init];
        self.transitionAnimation.isPush = true;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark -- UIViewControllerTransitioningDelegate


//返回处理push/pop动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.isPush = true;
        return self.transitionAnimation;
    }else if (operation == UINavigationControllerOperationPop){
        self.transitionAnimation.isPush = false;
    }
    return self.transitionAnimation;
}

////返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{

    //手势开始的时候才需要传入手势过渡代理，如果直接pop或push，应该返回nil，否者无法正常完成pop/push动作
//    if ( self.transitionAnimation.transitionType == WSLTransitionFourTypePop) {
//        return self.transitionInteractive.isInteractive == YES ? self.transitionInteractive : nil;
//    }
    return nil;
}


- (void)viewDidDisappear:(BOOL)animated{
    self.navigationController.delegate = nil;
}
@end
