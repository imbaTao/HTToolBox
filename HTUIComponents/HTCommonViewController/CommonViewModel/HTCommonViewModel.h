//
//  HTCommonViewModel.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 整型转字符串
#define INTTOSTRING(num) [NSString stringWithFormat:@"%zi",num]
#define FLOATTOSTRING(num) [NSString stringWithFormat:@"%lf",num]

@interface HTCommonViewModel : NSObject

- (void)vm;

@end

NS_ASSUME_NONNULL_END
