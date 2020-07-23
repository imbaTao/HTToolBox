//
//  UIImageView+HTImageView.m
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import "UIImageView+HTImageView.h"
#import "UIView+HTUIViewTool.h"


@implementation UIImageView (HTImageView)
+ (instancetype)name:(NSString *)name{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
}

+ (instancetype)name:(NSString *)name radius:(CGFloat)radius {
    UIImageView *v =  [self name:name];
    [v settingCornerRadius:radius];
    return v;
}

@end
