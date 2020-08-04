//
//  HTFlexibleFickleButton.m
//  Jihuigou-Native
//
//  Created by hong on 2020/5/9.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import "HTFlexibleFickleButton.h"

@implementation HTFlexibleFickleButton



- (instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color imgName:(NSString *)imgName position:(NSInteger)position {
    self = [super initWithHorizontalRotationButtonWithTitle:title font:font
                                                normalColor:color imgName:imgName position:position];
    if (self) {
        @weakify(self);
       [[RACObserve(self, interval) skip:1] subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self relayoutWithPositon:self.position];
           });
       }];
    }
    return self;
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
                
                if (img) {
                    make.size.mas_equalTo(HTSIZE(img.size.width, img.size.height));
                }
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
                if (img) {
                   make.size.mas_equalTo(HTSIZE(img.size.width, img.size.height));
                }
//                make.size.mas_equalTo(HTSIZE(img.size.width, img.size.height));
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


//- (void)flickButtonChangeIcon:(NSString *)value {
//    self.icon.image = [UIImage imageNamed:value];
//}


- (void)flickButtonChangeTitle:(NSString *)value {
      self.content.text = value;
     [self mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.offset(self.content.intrinsicContentSize.width + 6 + self.icon.size.width + self.interval);
     }];
}

@end
