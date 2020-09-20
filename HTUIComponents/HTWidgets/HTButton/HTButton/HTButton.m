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
     CGFloat minimumSide = self.hotAreaWidth;
    CGFloat differenceY = minimumSide - self.bounds.size.height;
    CGFloat differenceX = minimumSide - self.bounds.size.width;

    CGFloat insetY = MAX(0, differenceY);
    CGFloat insetX = MAX(0, differenceX);
   
    return CGRectContainsPoint(CGRectInset(self.bounds, -insetX, -insetY), point);
}


// 默认44
- (CGFloat)hotAreaWidth {
    if (!_hotAreaWidth) {
        _hotAreaWidth = 44;
    }
    return _hotAreaWidth;
}
@end
