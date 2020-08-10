//
//  HTCommonTableViewCell.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/9/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableViewCell : UITableViewCell

/**
 分割线
 */
@property(nonatomic, readwrite, strong)UIView *segementLine;


/**
 初始化UI
 */
- (void)setupUI;

- (void)renderWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
