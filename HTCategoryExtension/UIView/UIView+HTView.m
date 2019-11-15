//
//  UIView+HTView.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/12.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UIView+HTView.h"

@implementation UIView (HTView)

- (void)color:(UIColor *)color {
    self.backgroundColor = color;
}

- (void)whiteColor {
    self.backgroundColor = UIColor.whiteColor;
}

- (void)yellowColor {
    self.backgroundColor = UIColor.yellowColor;
}

- (void)redColor {
    self.backgroundColor = UIColor.redColor;
}

- (void)grayColor {
    self.backgroundColor = UIColor.grayColor;
}
@end
