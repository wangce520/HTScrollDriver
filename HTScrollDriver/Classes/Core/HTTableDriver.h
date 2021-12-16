//
//  HTTableDriver.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/12.
//


#import <UIKit/UIKit.h>
#import "HTScrollDriver.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTTableDriver : HTScrollDriver

/// 添加tableHeaderView
/// @param headerClassName 类名
/// @param headerData 数据
- (void)addTableViewHeader:(NSString *)headerClassName headerData:(id)headerData;

/// 添加tableFooterView
/// @param footerClassName 类名
/// @param footerData 数据
- (void)addTableViewFooter:(NSString *)footerClassName footerData:(id)footerData;

/// 移除tableHeaderView
- (void)removeTableViewHeader;

/// 移除tableFooterView
- (void)removeTableViewFooter;

@end

NS_ASSUME_NONNULL_END
