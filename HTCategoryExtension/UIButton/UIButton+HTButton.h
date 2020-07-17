//
//  UIButton+HTButton.h
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HTButton)

/**
 @param title 标题
 @param selctor 选择器
 @param target 目标
 @param iconName 图标名
 */
+ (instancetype)title:(NSString *)title selector:(SEL)selctor target:(id)target iconName:(NSString *)iconName;

/**
 改变按钮标题
 */
- (void)changeTitle:(NSString *)title;

/**
 @param title 标题
 @param size 标题字体大小
 @param iconName 图标名
 */
+ (instancetype)title:(NSString *)title iconName:(NSString *)iconName fontSize:(CGFloat)size;

/**
 根据图标名创建简单状态button
 @param iconName 图标名
 */
+ (instancetype)buttonWithIconName:(NSString *)iconName;


/**
 根据图标名创建简单状态button
 @param normalIconName 普通图标名
 @param seletedIconName 选中图标名
 */
+ (instancetype)buttonWithNormalIconName:(NSString *)normalIconName seletedIconName:(NSString *)seletedIconName;

/**
 @param title 标题
 @param font 标题字体
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleCorlor font:(UIFont *)font;

/**
 @param title 标题
 @param titleCorlor 标题颜色
 @param font 标题字体
 @param backGroundColor 标题
 @param radius 倒圆角
 
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleCorlor font:(UIFont *)font backGroundColor:(nullable UIColor *)backGroundColor cornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
