//
//  UIImage+HTEx.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UIImage+HTEx.h"

@implementation UIImage (HTUIImage)

+ (UIImage *)name:(NSString *)name {
    if (name.length == 0) {
        return [[UIImage alloc] init];
    }else {
        return [UIImage imageNamed:name];
    }
}


/**
 批量下载图片
 保持顺序;
 全部下载完成后才进行回调;
 回调结果中,下载正确和失败的状态保持与原先一致的顺序;
*/
- (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void (^)(NSArray * _Nonnull, NSArray * _Nonnull))completionBlock {
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
        manager.downloadTimeout = 20;
        __block NSMutableDictionary *resultImageDict = [NSMutableDictionary new];
    __block NSMutableDictionary *resultDic = [NSMutableDictionary new];
        for(int i=0;i<imgsArray.count;i++) {
            NSString *imgUrl = [imgsArray objectAtIndex:i];
            if (!imgUrl.hasValue) {
                imgUrl = @"";
//                BWLog(@"下标为--%i的图片地址为空",i);
            }
//            if (![imgUrl containsString:@"http"]) {
//                imgUrl = [NSString stringWithFormat:@"%@%@",[JHGAppConfig shareConfig].imageRouterUrl,imgUrl];
//            }
            [manager downloadImageWithURL:[NSURL URLWithString:imgUrl] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    //            BWLog(@"接收：%li---剩余：%li",receivedSize,expectedSize);
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if(finished){
                    if(error){
                        //在对应的位置放一个占位图
                        [resultImageDict setObject:@"" forKey:@(i)];
                        [resultDic setObject:@(NO) forKey:@(i)];
                    }else{
                        [resultImageDict setObject:image forKey:@(i)];
                        [resultDic setObject:@(YES) forKey:@(i)];
                    }
                    if(resultImageDict.count == imgsArray.count) {
                        //全部下载完成 此时回到主线程中做下一步操作
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSArray *resultImageArray = [self createDownloadResultArray:resultImageDict count:imgsArray.count];
                            NSArray *resultArr = [self createDownloadResultArray:resultDic count:imgsArray.count];
                            if(completionBlock){
                                completionBlock(resultImageArray,resultArr);
                            }
                        });
                    }
                }
            }];
        }
}

- (NSArray *)createDownloadResultArray:(NSDictionary *)dict count:(NSInteger)count {
    NSMutableArray *resultArray = [NSMutableArray new];
    for(int i=0;i<count;i++) {
        NSObject *obj = [dict objectForKey:@(i)];
        [resultArray addObject:obj];
    }
    return resultArray;
}
@end
