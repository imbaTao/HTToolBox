//
//  HTCommonEmptyView.m
//  Youni
//
//  Created by Mr.hong on 2020/8/5.
//  Copyright © 2020 韦瑀. All rights reserved.
//

#import "HTCommonEmptyView.h"

@interface HTCommonEmptyView()
/**
 emptyIcon
 */
@property(nonatomic, readwrite, strong)UIImageView *emptyIcon;

/**
 emptyTips
 */
@property(nonatomic, readwrite, strong)UILabel *emptyTips;


@end

@implementation HTCommonEmptyView

- (instancetype)initWithEmptyIconPath:(NSString *)emptyPath emptyTips:(NSString *)emptyTips font:(UIFont *)font textColor:(UIColor *)textColor interval:(CGFloat)interval offset:(CGPoint)offset {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.emptyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:emptyPath]];
        self.emptyTips = [UILabel font:font color:textColor textAlignment:NSTextAlignmentCenter placeholder:emptyTips];
        
        
        @weakify(self);
        [self setupLayout:^{
            @strongify(self);
            [self.emptyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).offset(offset.x);
                make.centerY.equalTo(self).offset(offset.y);
            }];
            
            [self.emptyTips mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.emptyIcon.mas_bottom).offset(interval);
                make.centerX.equalTo(self.emptyIcon);
            }];
        }];
    }
    return self;
}

@end
