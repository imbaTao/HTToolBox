//
//  UIFont+HTFont.m
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/7.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import "UIFont+HTFont.h"

#define W_RATIO [UIScreen mainScreen].bounds.size.width / IPHone6sSize.width
#define IPHone6sSize CGSizeMake(375, 667)

@implementation UIFont (HTFont)
+ (instancetype)fontSize:(CGFloat)size{

//    if (SCREEN_W == 320) {
//        return [UIFont systemFontOfSize:size * W_RATIO - 1];
//    }else if (SCREEN_W == 375){
        return [UIFont systemFontOfSize:size * W_RATIO];
//    }else{
//        return [UIFont systemFontOfSize:size * W_RATIO + 1];
//    }
}

+ (instancetype)fontSize:(CGFloat)size name:(NSString *)name {
//    if (SCREEN_W == 320) {
//        return [UIFont fontWithName:name Size:size * W_RATIO - 1];
//    }else if (SCREEN_W == 375){
        return [UIFont fontWithName:name size:size * W_RATIO];
//    }else{
//        return [UIFont fontWithName:name Size:size * W_RATIO + 1];
//    }
}


+ (instancetype)boldFontSize:(CGFloat)size{
//    if (SCREEN_W == 320) {
//        return [UIFont boldSystemFontOfSize:size * W_RATIO - 1];
//    }else if (SCREEN_W == 375){
        return [UIFont boldSystemFontOfSize:size * W_RATIO];
//    }else{
//        return [UIFont boldSystemFontOfSize:size * W_RATIO + 1 ];
//    }
}

+ (instancetype)mediumFontSize:(CGFloat)size{
//    if (SCREEN_W == 320) {
//        return [UIFont systemFontOfSize:size * W_RATIO - 1 weight:UIFontWeightMedium];
//    }else if (SCREEN_W == 375){
        return [UIFont systemFontOfSize:size * W_RATIO weight:UIFontWeightMedium];
//    }else{
//        return [UIFont systemFontOfSize:size * W_RATIO + 1 weight:UIFontWeightMedium];
//    }
}


+ (instancetype)heavyFontSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size * W_RATIO weight:UIFontWeightHeavy];
}
@end
