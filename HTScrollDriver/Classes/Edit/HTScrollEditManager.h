//
//  HTScrollEditManager.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/14.
//

#import <Foundation/Foundation.h>
#import "HTScrollEditModelProtocol.h"

@class HTCommonSectionViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface HTScrollEditManager : NSObject

/// 将所有 model 的参数汇总，并且会判断是否有错误产生
/// @param sectionViewModles sectionViewModles
/// @param finishBlock result:是否成功，error:错误 editParams:汇总的参数
+ (void)buildEditParamsWithSectionViewModels:(NSArray <HTCommonSectionViewModel *>*)sectionViewModles finishBlock:(void(^)(BOOL result, NSError *error, NSDictionary *editParams))finishBlock;

/// 检查是否有值，不会验证数据是否准确
/// @param sectionViewModles sectionViewModles
+ (BOOL)vertifyHasValuesWithSectionViewModels:(NSArray <HTCommonSectionViewModel *>*)sectionViewModles;


@end

NS_ASSUME_NONNULL_END
