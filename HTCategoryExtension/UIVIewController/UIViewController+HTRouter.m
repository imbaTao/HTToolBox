//
//  UIViewController+HTRouter.m
//  Youni
//
//  Created by Mr.hong on 2020/7/15.
//  Copyright © 2020 韦瑀. All rights reserved.
//

#import "UIViewController+HTRouter.h"

@implementation UIViewController (HTRouter)

static char  *ParamKey = "ParamKey";

- (NSDictionary *)param {
    return objc_getAssociatedObject(self, ParamKey);
}

- (void)setParam:(NSDictionary *)param {
    objc_setAssociatedObject(self,ParamKey, param, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
