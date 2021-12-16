//
//  HTDataCenter.h
//  hunter
//
//  Created by zzzz on 2021/11/22.
//  Copyright © 2021 zhuanzhuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommonSectionViewModel.h"
#import "HTCommonItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTDriverData : NSObject

/// HTCommonSectionViewModel组成的数组，适用于UICollectionView&UITableView
@property (nonatomic, strong) NSMutableArray <HTCommonSectionViewModel *>*scrollViewData;

/// 清除所有的数据
- (void)clearAll;

#pragma mark - Section Methods

/// 添加一个指定tag的section
- (void)addSectionWithTag:(NSInteger)tag;

/// 移除指定 tag 的section
- (void)removeSectionWithTag:(NSInteger)tag;

#pragma mark - Cell Methods

/// 添加一个cell
- (void)addCellViewModel:(HTCommonItemViewModel *)cellViewModel toSection:(NSInteger)sectionTag;

/// 添加多个cell
- (void)addCellViewModels:(NSArray<HTCommonItemViewModel *> *)cellViewModels toSection:(NSInteger)sectionTag;

#define mark - Header&Footer Methods

/// 添加一个 sectionViewHeader
- (void)addSectionHeaderViewModel:(HTCommonItemViewModel *)headerViewModel toSection:(NSInteger)sectionTag;

/// 添加一个 sectionViewFooter
- (void)addSectionFooterViewModel:(HTCommonItemViewModel *)footerViewModel toSection:(NSInteger)sectionTag;

@end

NS_ASSUME_NONNULL_END
