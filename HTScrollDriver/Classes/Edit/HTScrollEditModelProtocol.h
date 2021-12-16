//
//  HTScrollEditModelProtocol.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/14.
//

#import <Foundation/Foundation.h>

@protocol HTScrollEditModelProtocol <NSObject>

/// 最后提交时的参数
- (NSDictionary *)editParams;

/// 检查是否有数据，不会验证数据的准确性，主要是为了满足页面有值或者无值时，改变提交按钮的状态
- (BOOL)hasValues;

/// 判断数据是否准确，同时需要判断是否有数据，如果有错，需要返回 NSError
- (NSError *)verifyValues;

/// 是否为必填项
- (BOOL)isRequired;

@end
