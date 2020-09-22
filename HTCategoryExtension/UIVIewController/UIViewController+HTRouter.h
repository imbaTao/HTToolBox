//
//  UIViewController+HTRouter.h
//  Youni
//
//  Created by Mr.hong on 2020/7/15.
//  Copyright © 2020 韦瑀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HTRouter)


/**
 param
 */
@property(nonatomic, readwrite, copy)NSDictionary *param;

@end

NS_ASSUME_NONNULL_END
