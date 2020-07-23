//
//  UIImageView+HTImageView.h
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (HTImageView)
+ (instancetype)name:(NSString *)name;

/**
 根据图片和圆角名初始化
 */
+ (instancetype)name:(NSString *)name radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
