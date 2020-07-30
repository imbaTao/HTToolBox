//
//  HTFlexibleFickleButton.m
//  Jihuigou-Native
//
//  Created by hong on 2020/5/9.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import "HTFlexibleFickleButton.h"

@implementation HTFlexibleFickleButton



- (NSInteger)interval {
    if (!_interval) {
        _interval = 4;
        @weakify(self);
          [[RACObserve(self, interval) skip:1] subscribeNext:^(id  _Nullable x) {
              @strongify(self);
              [self relayoutWithPositon:self.position];
          }];
    }
    return _interval;
}

// 子类复写
// 子类复写
- (void)relayoutWithPositon:(NSInteger)position {
    

    
    // 抗压缩
    //    [self.content setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //    self.content.backgroundColor = [UIColor blueColor];
    
    
    
    
    //        [self.likeButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // 抗拉伸
    [self.content setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    // 抗压缩
    [self.icon setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    // 抗拉伸
    [self.icon setContentHuggingPriority:UILayoutPriorityDragThatCanResizeScene forAxis:UILayoutConstraintAxisHorizontal];
    
    
    
    
    UIImage *img = self.icon.image;
    switch (position) {
        case 0:{
            // layout
            [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.centerY.equalTo(self);
                make.right.equalTo(self.content.mas_left).offset(-self.interval);
                make.size.mas_equalTo(HTSIZE(img.size.width, img.size.height));
            }];
            
            [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.icon.mas_right).offset(self.interval);
                make.centerY.equalTo(self);
                make.right.offset(0);
            }];
        }break;
        case 1:{
            [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_lessThanOrEqualTo(0);
                make.centerY.equalTo(self);
                make.size.mas_equalTo(HTSIZE(img.size.width, img.size.height));
            }];
            // layout
            [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.centerY.equalTo(self);
                make.right.equalTo(self.icon.mas_left).offset(-self.interval);
            }];
        }break;
        default:break;
    }
}





- (void)changeNewTitle:(NSString *)newValue {
    self.content.text = newValue;
}

@end
