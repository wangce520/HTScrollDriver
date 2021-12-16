//
//  HTScrollEditManager.m
//  EasyTableView
//
//  Created by 王策 on 2021/11/14.
//

#import "HTScrollEditManager.h"
#import "HTCommonSectionViewModel.h"
#import "HTCommonItemViewModel.h"

@implementation HTScrollEditManager

/// 将所有 model 的参数汇总，并且会判断是否有错误产生
/// @param sectionViewModles sectionViewModles
/// @param finishBlock result:是否成功，error:错误 editParams:汇总的参数
+ (void)buildEditParamsWithSectionViewModels:(NSArray <HTCommonSectionViewModel *>*)sectionViewModles finishBlock:(void(^)(BOOL result, NSError *error, NSDictionary *editParams))finishBlock{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    
    for (HTCommonSectionViewModel *sectionViewModel in sectionViewModles) {
        NSError *error = [self addParamsToMutableDict:mDict editModel:sectionViewModel.headerViewModel.viewData];
        if (error) {
            if (finishBlock) {
                finishBlock(NO, error, nil);
            }
            break;
        }
        
        for (HTCommonItemViewModel *itemViewModel in sectionViewModel.cellViewModels) {
            error = [self addParamsToMutableDict:mDict editModel:itemViewModel.viewData];
            if (error) {
                break;
            }
        }
        
        if (error) {
            if (finishBlock) {
                finishBlock(NO, error, nil);
            }
            break;
        }
        
        error = [self addParamsToMutableDict:mDict editModel:sectionViewModel.footerViewModel.viewData];
        if (error) {
            if (finishBlock) {
                finishBlock(NO, error, nil);
            }
            break;
        }
    }
    
    if (finishBlock) {
        finishBlock(YES, nil, [mDict copy]);
    }
}

/// 检查是否有值，不会验证数据是否准确
/// @param sectionViewModles sectionViewModles
+ (BOOL)vertifyHasValuesWithSectionViewModels:(NSArray <HTCommonSectionViewModel *>*)sectionViewModles{
        
    for (HTCommonSectionViewModel *sectionViewModel in sectionViewModles) {
        
        if (![self vertifyHasValuesWithEditModel:sectionViewModel.headerViewModel.viewData]) {
            return NO;
        }
        
        for (HTCommonItemViewModel *itemViewModel in sectionViewModel.cellViewModels) {
            if (![self vertifyHasValuesWithEditModel:itemViewModel.viewData]) {
                return NO;
            }
        }
        
        if (![self vertifyHasValuesWithEditModel:sectionViewModel.footerViewModel.viewData]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Helper

/// 检查 editModel 是否有值
+ (BOOL)vertifyHasValuesWithEditModel:(NSObject <HTScrollEditModelProtocol> *)editModel{
    return editModel.isRequired && !editModel.hasValues;
}

/// 添加 editModel 中的参数到总的参数字典中
+ (NSError *)addParamsToMutableDict:(NSMutableDictionary *)mDict editModel:(NSObject <HTScrollEditModelProtocol> *)editModel{
    NSError *resultError = nil;
    if (editModel && [editModel conformsToProtocol:@protocol(HTScrollEditModelProtocol)]) {
        BOOL isRequired = editModel.isRequired;
        NSError *error = editModel.verifyValues;
        NSDictionary *params = editModel.editParams;
        if (isRequired && error) {
            resultError = error;
        }else if(params){
            [mDict addEntriesFromDictionary:params];
        }
    }
    return resultError;
}

@end
