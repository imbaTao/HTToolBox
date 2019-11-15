//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "HTCycleViewManager.h"
#import "JHGProductCommonDetailViewController.h"
#import "HTBaseCollectionView.h"


#import "JHGGroupShoppingOrderSuccessVC.h"
#import "JHGGroupShoppingHomeVC.h"
#import "JHGSeckillProductDetailPriceFlagView.h"
#import "JHGMyWalletBillViewController.h"
#import "JHGMyWalletViewController.h"

#define ISDEBUGER 0
@interface HTDebugger ()
@end
@implementation HTDebugger
singleM();

- (BOOL)debugerWithKewindow:(UIWindow *)window {
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    
    if (!ISDEBUGER) {
         return false;
    }else {
        // 要调试第几个VC
        self.debugVcIndex = 0;
        
        UIViewController *testVC;
        
        JHGMyWalletViewModel *vm = [[JHGMyWalletViewModel alloc] init];
        vm.canPulldown = false;
        vm.classNames = @[@"JHGJHGMyWalletCouponCell"];
        vm.contentInset = UIEdgeInsetsMake(NavigationBarHeight, 0, 0, 0);
        testVC = [[JHGMyWalletViewController alloc] initWithViewModel:vm];

        
        self.vcNames = @[
                         @"HTDebuggerViewController",
                         @"JHGGroupShoppingOrderSuccessVC",
                         @"JHGHomeViewController",
                         ];
        if (!testVC) {
            testVC =  [[NSClassFromString(self.vcNames[self.debugVcIndex]) alloc] init]; 
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];
        [window makeKeyAndVisible];
        window.rootViewController = nav;
        return true;
    }
}

@end

#import "JHGJHGMyWalletHeaderView.h"
#import "JHGJHGMyWalletCouponCell.h"
#import "JHGMyWalletViewController.h"
#import "HTFickleButton.h"
#import "JHGMyWalletBillViewController.h"


@interface  HTDebuggerViewController : UIViewController<HTCycleViewDelegate,UITableViewDelegate,UITableViewDataSource>


/**
 data
 */
@property(nonatomic, readwrite, strong)NSArray *data;



@end


@implementation HTDebuggerViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
//  JHGMyWalletBillViewModel *vm = [[JHGMyWalletBillViewModel alloc] init];
//    vm.classNames = @[@"JHGMyWalletBillCell"];
//    vm.contentInset = UIEdgeInsetsMake(NavigationBarHeight + 80, 0, 0, 0);
//    JHGMyWalletBillViewController *billVC = [[JHGMyWalletBillViewController alloc] initWithViewModel:vm];
//    [self.navigationController pushViewController:billVC animated:true];
    

    
    [self injected];
}


- (void)injected
{
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    
    JHGMyWalletViewModel *vm = [[JHGMyWalletViewModel alloc] init];
    vm.canPulldown = false;
    vm.classNames = @[@"JHGJHGMyWalletCouponCell"];
    vm.contentInset = UIEdgeInsetsMake(NavigationBarHeight, 0, 0, 0);
    JHGMyWalletViewController  *testVC = [[JHGMyWalletViewController alloc] initWithViewModel:vm];
    [self.navigationController pushViewController:testVC animated:true];
    
}



@end
