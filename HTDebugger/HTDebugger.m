//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "HTDebuggerViewController.h"
#import "HTCommonTabbarController.h"
#import "HTFPSLabel.h"
#import "YNArticleDetailCommonModel.h"


#import "HomeController.h"
#define ISDEBUGER 0
@implementation HTDebugger

singleM();
- (BOOL)debugerWithKewindow:(UIWindow *)window {
     
    if (!window) {
      window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
      window.backgroundColor = [UIColor whiteColor];
      [window makeKeyAndVisible];
      [UIApplication sharedApplication].delegate.window = window;
    }
    
    // 这个暂时用不了了
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HTFPSLabel *label = [[HTFPSLabel alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 100
                                                                         , HTStatusBarTopHeight, 50, 20)];
        if (window.safeAreaInsets.top > 0) {
//             label.x = 30;
             label.y = 0;
         }
        [window addSubview:label];
    });
    if (!ISDEBUGER) {
        return false;
    }else {
        // 默认跳转测试控制器
        UIViewController *testVC = [[HTDebuggerViewController alloc] init];

        
        
//         SelectIdentityController EnterpriseInfoCompleteController
//        PersonalAuthController 个人
        
        
//        CampusInfoCompleteController
        
//        CampusCertificationController //校园 组织认证
//        testVC = [[NSClassFromString(@"UniversityController") alloc] init];
        
//         testVC = [[NSClassFromString(@"ActivityReleaseController") alloc] init];
//       testVC = [[NSClassFromString(@"PublishLongArticlesController") alloc] init];
        
        
//        YNArticleDetailCommonModel *model = [[YNArticleDetailCommonModel alloc] init];
//        model.ID = @"668";
//        model.title = @"第十五届校园热舞大赛";
//        model.content = @"动感地带全国大学生电视挑战赛于2004年首次举办，分别设有齐舞项目还有Breakin crew battle。从04年到08年，动感地带街舞比赛的规模逐年增长，并成为了国内最有号召力的大型街舞赛事。2003年由中央电视台体育节目中心、国家体育总局体操运动管理中心，中视体育推广有限公司承办第一、第二、第三届全国街舞电视大赛，取得了极大的成功，吸引了一千多名专业和业余街舞选手参加，获得了良好的社会效益．大赛用规范化的体育竞赛形式、系统的评分规则、公开公正的评判原则来组织街舞比赛，受到新闻媒体和社会各界极大的关注．体育竞赛的特殊魅力吸引了各地千余名酷爱街舞的青年参加，为他们提供了一个展示街舞风采的最好舞台。";
//        model.startTime = @"星期六，7月20日";
//        model.endTime = @"1:30 pm - 3:30 pm";
//        model.personId = USER.ID;
//        model.logo = USER.logo;
//        model.nickname = USER.nickname;
//        testVC = [[NSClassFromString(@"YNArticleDetailActivityViewController") alloc] init];
//         testVC.param = @{@"detailModel" : model};


        
        
        
        
        HomeController *vc = [[HomeController alloc] init];
//        vc.view.backgroundColor = [UIColor redColor];
////
        testVC = vc;
//           [vc cameraBtnClick];
        
        
        /** ----------------------------- 分割线 ------------------------------ */
        UITabBarController *tab = [[UITabBarController alloc] init];
        tab.tabBar.hidden = true;
        [tab.tabBar removeFromSuperview];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];
        [tab setViewControllers:@[nav]];
        window.rootViewController = tab;
        return true;
    }
}


@end


