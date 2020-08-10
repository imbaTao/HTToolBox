//
//  HTAuthorizer.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/22.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTAuthorizer.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface HTAuthorizer()<UIAlertViewDelegate>
@end
@implementation HTAuthorizer

- (UIWindow *)ht_KeyWindow {
    if (@available(iOS 13.0, *)) {
        return [UIApplication sharedApplication].windows.firstObject;
    }else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

// 获取相机权限
+ (void)fetchCameraAuthorizationStatus:(void (^)(BOOL result))resultBlock{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        // 无权限显示权限弹窗
//        [self _showSettingTipsWithType:1];
        
        [self _showSettingTipsWithType:1];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (!granted) {
                [self _showSettingTipsWithType:1];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(granted);
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(true);
        });
        
    }
}

// 获取相册权限
+ (void)fetchPhotoLibraryAuthorizationStatus:(void (^)(BOOL result))resultBlock{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ((status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)) {
                // 无权限显示权限弹窗
                [self _showSettingTipsWithType:2];
            } else if (status == PHAuthorizationStatusNotDetermined) {
                resultBlock(false);
            } else {
                resultBlock(true);
            }
        });
    }];
}

// 展示前往设置界面的面板
+ (void)_showSettingTipsWithType:(NSInteger)type {
      NSString *title = @"";
        NSString *message = @"";
        NSString *appName = [self _appName];
        switch (type) {
            case 0:{// 相机
               title = @"无法使用相机";
               message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许%@访问相机",appName];
            }break;
            case 1:{// 相册
                title = @"无法访问相册";
                message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相册\"中允许%@访问相册",appName];
            }break;
            case 2:{// 定位
                title = @"无法使用GPS定位";
                message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-定位\"中允许%@访问GPS",appName];
            };
                
            default:break;
        }
        
        UIAlertController *alertViewVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
          UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          }];
          
          UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
              if ([[UIApplication sharedApplication] canOpenURL:url]){
                  [[UIApplication sharedApplication] openURL:url];
              }
          }];
          
          [alertViewVC addAction:cancleAction];
          [alertViewVC addAction:settingAction];
          [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertViewVC animated:true completion:nil];
}

//
//dispatch_async(dispatch_get_main_queue(), ^{
//       NSDictionary *infoDict = [self getInfoDictionary];
//
//       // 提示
//       NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
//       if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
//       if (!appName) appName = [infoDict valueForKey:@"CFBundleExecutable"];
//       NSString  *title = @"无法使用相机";
//       NSString *message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许%@访问相机",appName];
//       if (type == 2) {
//           title = @"无法访问相册";
//           message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相册\"中允许%@访问相册",appName];;
//       }
//
//       UIAlertController *alertViewVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//       UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//       }];
//
//       UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//       }];
//
//       [alertViewVC addAction:cancleAction];
//       [alertViewVC addAction:settingAction];
//       [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertViewVC animated:true completion:nil];
//   });

// 获取GPS权限
+ (void)fetchGPSAuthorizationStatus:(void (^)(BOOL))resultBlock {
     BOOL status = [CLLocationManager locationServicesEnabled];
     if (!status) {
         CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
         if (CLstatus == kCLAuthorizationStatusDenied || CLstatus == kCLAuthorizationStatusDenied) {
             [self _showSettingTipsWithType:3];
             //未授权
             resultBlock(false);
         }else {
             resultBlock(true);
         }
     }else {
         resultBlock(false);
     }
}

+ (NSString *)_appName {
    // APP名称
     NSDictionary *infoDict = [self _getInfoDictionary];
     NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
     if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
     if (!appName) appName = [infoDict valueForKey:@"CFBundleExecutable"];
    return appName;
}

//#pragma mark -权限检测
///**
// (相机)权限
// */
//- (BOOL)iPhoneSystemPermissionCamera{
//
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
//        //未授权
//        [self showAlertViewWithType:PermissionMessageTypeCamera];
//        return NO;
//    }
//    return YES;
//
//}
//
///**
// (相册)权限
// */
//- (BOOL)iPhoneSystemPermissionPhotoLibrary{
//
//    if (IPHONE_SYSTEM_VERSION >= 8.0) {
//        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//        if(status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
//            //未授权
//            [self showAlertViewWithType:PermissionMessageTypePhotoLibrary];
//            return NO;
//        }
//    }
//    if (IPHONE_SYSTEM_VERSION >= 6.0 && IPHONE_SYSTEM_VERSION < 8.0){
//        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
//        if(status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
//            //未授权
//            [self showAlertViewWithType:PermissionMessageTypePhotoLibrary];
//            return NO;
//        }
//    }
//    return YES;
//
//}
//
///**
// (通知)权限
// */
//- (BOOL)iPhoneSystemPermissionNotification{
//
//    if (IPHONE_SYSTEM_VERSION >= 8.0){
//        UIUserNotificationSettings *status = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        if (status.types == UIUserNotificationTypeNone){
//            //未授权
//            [self showAlertViewWithType:PermissionMessageTypeNotification];
//            return NO;
//        }
//    }else{
//        UIRemoteNotificationType status = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        if(status == UIRemoteNotificationTypeNone){
//            //未授权
//            [self showAlertViewWithType:PermissionMessageTypeNotification];
//            return NO;
//        }
//    }
//    return YES;
//
//}

/**
// (网络)权限
// */
//- (void)iPhoneSystemPermissionNetwork{
//
//    CTCellularData *cellularData = [[CTCellularData alloc] init];
//    __weak typeof(self) weakSelf = self;
//    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
//        if (state == kCTCellularDataRestricted) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf showAlertViewWithType:PermissionMessageTypeNetwork];
//            });
//
//        }
//    };
//
//}
//
///**
// (麦克风)权限
// */
//- (BOOL)iPhoneSystemPermissionAudio{
//
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
//        //未授权
//        [self showAlertViewWithType:PermissionMessageTypeAudio];
//        return NO;
//    }
//    return YES;
//
//}




///**
// (通讯录)权限
// */
//- (BOOL)iPhoneSystemPermissionAddressBook{
//
//    if (IPHONE_SYSTEM_VERSION >= 9.0) {
//        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//        if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted){
//            //未授权
//            [self showAlertViewWithType:PermissionMessageTypeAddressBook];
//            return NO;
//        }
//    }else{
//        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
//        if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted){
//            //未授权
//            [self showAlertViewWithType:PermissionMessageTypeAddressBook];
//            return NO;
//        }
//    }
//    return YES;
//}


///**
// (日历)权限
// */
//- (BOOL)iPhoneSystemPermissionCalendar{
//
//    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
//    if (status == EKAuthorizationStatusDenied || status == EKAuthorizationStatusRestricted){
//        //未授权
//        [self showAlertViewWithType:PermissionMessageTypeCalendar];
//        return NO;
//    }
//    return YES;
//
//}


///**
// (备忘录)权限
// */
//- (BOOL)iPhoneSystemPermissionReminder{
//
//    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
//    if (status == EKAuthorizationStatusDenied || status == EKAuthorizationStatusRestricted){
//        //未授权
//        [self showAlertViewWithType:PermissionMessageTypeReminder];
//        return NO;
//    }
//    return YES;
//
//}

#pragma mark -跳转设置界面
/**
 提示框
 */
//- (void)showAlertViewWithType:(PermissionMessageType)type{
//    NSString *title;
//
//    switch (type) {
//        case PermissionMessageTypeCamera:
//            title = [NSString stringWithFormat:@"允许“%@”使用相机?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypePhotoLibrary:
//            title = [NSString stringWithFormat:@"允许“%@”使用相册?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeNotification:
//            title = [NSString stringWithFormat:@"允许“%@”使用推送?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeNetwork:
//            title = [NSString stringWithFormat:@"如果一直遇到不能联网的问题，请尝试前往手机的设置-无线局域网-使用无线局域网与蜂窝移动的应用中，进入列表中任意一项切换一下状态，再回到%@进行网络授权。", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeAudio:
//            title = [NSString stringWithFormat:@"允许“%@”使用麦克风?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeLocation:
//            title = [NSString stringWithFormat:@"允许“%@”使用定位?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeAddressBook:
//            title = [NSString stringWithFormat:@"允许“%@”使用通讯录?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeCalendar:
//            title = [NSString stringWithFormat:@"允许“%@”使用日历?", SJ_AP_NAME];
//            break;
//        case PermissionMessageTypeReminder:
//            title = [NSString stringWithFormat:@"允许“%@”使用备忘录?", SJ_AP_NAME];
//            break;
//        default:
//            break;
//    }
//
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"我知道了", nil];
//    alertView.delegate = self;
//    [alertView show];
//    alertView.tag = type;
//}

#pragma mark -- AlertView Delegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    if (buttonIndex == 0){
//        [self openIPhoneSystemSettingPageAfterIOS8];
//        [self openIPhoneSystemSettingPageBeforeIOS8WithType:alertView.tag];
//    }
//}


///**
// iOS8以后_设置界面
// */
//- (void)openIPhoneSystemSettingPageAfterIOS8{
//
//    if (IPHONE_SYSTEM_VERSION < 8.0) {
//        return;
//    }
//
//    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if ([[UIApplication sharedApplication] canOpenURL:url]){
//        [[UIApplication sharedApplication] openURL:url];
//    }
//
//}
//
///**
// iOS8以前_设置界面
// */
//- (void)openIPhoneSystemSettingPageBeforeIOS8WithType:(PermissionMessageType)type{
//
//    if (IPHONE_SYSTEM_VERSION >= 8.0) {
//        return;
//    }
//
//    NSURL *url;
//    switch (type) {
//        case PermissionMessageTypeCamera:
//            url = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
//            break;
//        case PermissionMessageTypePhotoLibrary:
//            url = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
//            break;
//        case PermissionMessageTypeNotification:
//            break;
//        case PermissionMessageTypeNetwork:
//            url = [NSURL URLWithString:@"prefs:root=General&path=Network"];
//            break;
//        case PermissionMessageTypeAudio:
//            url = [NSURL URLWithString:@"prefs:root=Privacy&path=Audio"];
//            break;
//        case PermissionMessageTypeLocation:
//            url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//            break;
//        case PermissionMessageTypeAddressBook:
//            url = [NSURL URLWithString:@"prefs:root=Privacy&path=AddressBook"];
//            break;
//        case PermissionMessageTypeCalendar:
//            url = [NSURL URLWithString:@"prefs:root=Privacy&path=Calendar"];
//            break;
//        case PermissionMessageTypeReminder:
//            url = [NSURL URLWithString:@"prefs:root=Privacy&path=NOTES"];
//            break;
//
//        default:
//            break;
//    }
//    if ([[UIApplication sharedApplication] canOpenURL:url]){
//        [[UIApplication sharedApplication] openURL:url];
//    }
//
//}
//@end


// 获得Info.plist数据字典
+ (NSDictionary *)_getInfoDictionary {
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return infoDict ? infoDict : @{};
}
@end
