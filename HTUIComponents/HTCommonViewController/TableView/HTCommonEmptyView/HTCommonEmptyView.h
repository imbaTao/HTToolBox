//
//  HTCommonEmptyView.h
//  Youni
//
//  Created by Mr.hong on 2020/8/5.
//  Copyright © 2020 韦瑀. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonEmptyView : UIView

/**
 emptyIcon
 */
@property(nonatomic, readwrite, strong)UIImageView *emptyIcon;

/**
 emptyTips
 */
@property(nonatomic, readwrite, strong)UILabel *emptyTips;

/**
 初始化
 */
- (instancetype)initWithEmptyIconPath:(NSString *)emptyPath emptyTips:(NSString *)emptyTips font:(UIFont *)font textColor:(UIColor *)textColor interval:(CGFloat)interval offset:(CGPoint)offset;

@end

NS_ASSUME_NONNULL_END
