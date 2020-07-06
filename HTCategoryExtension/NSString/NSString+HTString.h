//
//  NSString+HTString.h
//  HTPlace
//
//  Created by Mr.hong on 2020/5/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTString)

/**
 是否有值
 */
@property(nonatomic, readwrite, assign)bool hasValue;


/**
传入字体、最大尺寸，直接获取实际尺寸
@param font 字体
@param size 最大尺寸
@param lineBreakMode 字体的分割模式
*/

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;


/**
 传入字体、高度，直接获取宽度
 @param font 字体
 @param height 字体的高度限制值
 @param model 字体的分割模式
 */
- (CGFloat)widthForFont:(UIFont *)font height:(CGFloat)height model:(NSLineBreakMode)model;


/**
传入字体、宽度，直接获取高度
@param font 字体
@param width 字体的高度限制值
@param model 字体的分割模式
*/
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width model:(NSLineBreakMode)model;

/**
获取指定长度的字符串,包含中文的，中文字符算几位 bit 传1或2
*/
- (NSString *)fetchLengthWithText:(NSString *)text length:(NSInteger)length chineseBit:(NSInteger)bit;

/**
 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 */
+ (NSString *)firstCharactor:(NSString *)aString;


/**
 根据最大尺寸，字体，获取文本尺寸
 */
- (CGSize)boundingRectWithSize:(CGSize)size withFont:(NSInteger)font;


//手机号有效性
- (BOOL)isMobileNumber;

@end

NS_ASSUME_NONNULL_END
