//
//  HTButton.m
//  Youni
//
//  Created by Mr.hong on 2020/8/20.
//  Copyright © 2020 韦瑀. All rights reserved.
//

#import "HTButton.h"

@implementation HTButton

- (BOOL)pointInside:(CGPoint)point
          withEvent:(UIEvent *)event {
    const static CGFloat minimumSide = 0;
    CGFloat differenceY = minimumSide - self.bounds.size.height;
    CGFloat differenceX = minimumSide - self.bounds.size.width;

    CGFloat insetY = MAX(0, differenceY);
    CGFloat insetX = MAX(0, differenceX);

    return CGRectContainsPoint(CGRectInset(self.bounds, -insetX, -insetY), point) || [super pointInside:point withEvent:event];
}
@end
