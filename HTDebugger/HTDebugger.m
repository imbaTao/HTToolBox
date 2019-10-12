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
        
//        HTCommonTableViewModel *vm = [[HTCommonTableViewModel alloc] init];
//        vm.canPullUp = false;
//        vm.canPulldown = false;
//        testVC = [[JHGProductCommonDetailViewController alloc] initWithViewModel:vm];
        
        // 已加入调试队列的vc名字
        self.vcNames = @[
                         @"HTDebuggerViewController",
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
@interface  HTDebuggerViewController : UIViewController<HTCycleViewDelegate>

/**
 tempView
 */
@property(nonatomic, readwrite, strong)HTCommonCollectionView *tempView;

@end

@implementation HTDebuggerViewController
- (void)viewDidLoad {
    [self injected];
 
}

- (void)injected
{
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    
//
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout creatWithLineSpacing:5 InteritemSpacing:0 itemCount:3 sectionInset:UIEdgeInsetsMake(0, 15, 0, 15) sourceSize:CGSizeMake(50, 70) scrollDirection:UICollectionViewScrollDirectionHorizontal];
//    _tempView = [[HTCommonCollectionView alloc] initWithFrame:CGRectZero layout:layout cellClassNames:nil delegateTarget:nil];
//    [self.view addSubview:_tempView];
//    
//    [_tempView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(100);
//        make.left.offset(0);
//        make.right.offset(0);
//        make.height.offset(layout.itemSize.height);
//    }];
//    
//    [[_tempView rac_signalForSelector:@selector(configureCell:atIndexPath:collectionView:)] subscribeNext:^(RACTuple * _Nullable x) {
//        HTCommonCollectionView *cell = x.first;
//        cell.backgroundColor = [UIColor redColor];
//    }];
//    
//    _tempView.data = [@[@1,@1,@1,@1,@1,@1] mutableCopy];
    
//  HTCycleView *cyleView = [HTCycleViewManager creatCyleViewWithStyle:HTCycleViewStyleNormalStyle size:CGSizeMake(BWScreenWidth, 200)];
//    cyleView.delegate = self;
//    [self.view addSubview:cyleView];
//    [cyleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(BWNavigationBarHeight);
//        make.left.offset(0);
//        make.size.mas_equalTo(CGSizeMake(BWScreenWidth, 200));
//    }];
//    cyleView.backgroundColor = [UIColor redColor];
//
//    [cyleView injectData:@[@"activity/201907041725451280_720x432.png",@"activity/201809061802425693_720x340.jpg",@"activity/201809061801228350_720x340.jpg",@"activity/201809061800416787_720x340.jpg",@"activity/201906050952203678_720x340.jpg"]];
}



/**
 当横向排布时，lineSpacing是两个item左右之间的间距,interitemSpacing为0,注意collectionView高度不能＞item高度两倍，不然换行
 当纵向排布是, lineSpacing是两个item上下之间的间距，interitemSpacing是左右间距
 */
-(UICollectionViewFlowLayout *)creatWithLineSpacing:(CGFloat)lineSpacing  InteritemSpacing:(CGFloat)interitemSpacing itemCount:(NSInteger)itemCount sectionInset:(UIEdgeInsets)sectionInset sourceSize:(CGSize)sourceSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = lineSpacing;
    layout.minimumInteritemSpacing = interitemSpacing;
    layout.scrollDirection = scrollDirection;
    layout.sectionInset = sectionInset;
    
    CGFloat itemAllWidth = 0;
    
    // 如果是纵向排列
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        itemAllWidth = BWScreenWidth - sectionInset.left - sectionInset.right - interitemSpacing * (itemCount - 1);
    }else {
    // 横向排列
        itemAllWidth = BWScreenWidth - sectionInset.left - sectionInset.right - lineSpacing * (itemCount - 1);
    }
    
  
    NSInteger cellWidth = itemAllWidth / itemCount;
    CGFloat mutiply = sourceSize.height / sourceSize.width;
    NSInteger cellHeight = cellWidth * mutiply;
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
    return layout;
}

@end
